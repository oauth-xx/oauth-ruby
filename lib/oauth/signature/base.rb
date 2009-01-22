require 'oauth/signature'
require 'oauth/helper'
require 'oauth/request_proxy/base'
require 'base64'

module OAuth::Signature
  class Base
    include OAuth::Helper
    
    attr_accessor :options
    
    def self.implements(signature_method)
      OAuth::Signature.available_methods[signature_method] = self
    end

    def self.digest_class(digest_class = nil)
      return @digest_class if digest_class.nil?
      @digest_class = digest_class
    end

    attr_reader :token_secret, :consumer_secret, :request

    def initialize(request, options = {}, &block)
      raise TypeError unless request.kind_of?(OAuth::RequestProxy::Base)
      @request = request
      @options = options

      if block_given?

        # consumer secret and token secret need to be looked up based on pieces of the request
        @token_secret, @consumer_secret = yield block.arity == 1 ? request : [token, consumer_key,nonce,request.timestamp]

      else
        ## consumer secret was determined beforehand

        @consumer_secret = options[:consumer].secret if options[:consumer]

        # presence of :consumer_secret option will override any Consumer that's provided
        @consumer_secret = options[:consumer_secret] if options[:consumer_secret]

        ## token secret was determined beforehand

        @token_secret = options[:token].secret if options[:token]

        # presence of :token_secret option will override any Token that's provided
        @token_secret = options[:token_secret] if options[:token_secret]
      end
    end

    def signature
      Base64.encode64(digest).chomp.gsub(/\n/,'')
    end

    def ==(cmp_signature)
      Base64.decode64(signature) == Base64.decode64(cmp_signature)
    end

    def verify
      self == self.request.signature
    end

    def signature_base_string
      request.signature_base_string
    end
    
    private

    def token
      request.token
    end
    
    def consumer_key
      request.consumer_key
    end
    
    def nonce
      request.nonce
    end

    def secret
      "#{escape(consumer_secret)}&#{escape(token_secret)}"
    end

    def digest
      self.class.digest_class.digest(signature_base_string)
    end

  end
end
