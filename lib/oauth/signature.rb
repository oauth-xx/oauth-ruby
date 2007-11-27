require 'cgi'
require 'hmac' # make sure to install: sudo gem install ruby-hmac
require 'hmac-sha1'
require 'hmac-md5'
require 'hmac-sha2'
require 'hmac-rmd160'

require 'base64'
module OAuth
  # Much of this code has been blatantly stolen fron Blaine Cooke of Twitter and Larry Halff of ma.gnolia.com
  # and lovingly hand modified with the utmost respect.
  
  # You should not need to use this directly as the request object encapsulates it in the sign and verify methods
  module Signature
    def self.create(oauth_request,consumer_secret,token_secret=nil)
      klass = case oauth_request.signature_method.downcase
      when 'hmac-md5': OAuth::Signature::HashedMessageAuth::MD5
      when 'hmac-sha1': OAuth::Signature::HashedMessageAuth::SHA1
      when 'hmac-sha2': OAuth::Signature::HashedMessageAuth::SHA2
      when 'hmac-rmd160': OAuth::Signature::HashedMessageAuth::RMD160
      when 'plaintext': 
        if oauth_request.uri.scheme=="https"
          OAuth::Signature::PLAINTEXT
        else
          raise InsecureSignatureMethod
        end
      when 'rsa-sha1': OAuth::Signature::RSA::SHA1
      when 'sha1': raise InsecureSignatureMethod, oauth_request.signature_method
      when 'md5': raise InsecureSignatureMethod, oauth_request.signature_method
      else
        raise UnknownSignatureMethod, oauth_request.signature_method
      end

      klass.new(oauth_request,consumer_secret,token_secret)
    end

    class UnknownSignatureMethod < Exception; end

    class InsecureSignatureMethod < Exception; end

    class Base
      include OAuth::Key
      
      attr_accessor :request

      def initialize(request,consumer_secret,token_secret=nil)
        @request=request
        @consumer_secret=consumer_secret
        @token_secret=token_secret
      end
    
      def base_string
        [@request.http_method,@request.normalized_url,@request.to_query_without_signature].collect{|p| @request.escape(p)}.join('&')
      end
    
      def key
        "#{@consumer_secret}&#{@token_secret}"
      end
    
      def consumer_secret
        @consumer_secret||=""
      end

      def token_secret
        @token_secret||=""
      end
    
      def sign
        Base64.encode64(digest).chomp
      end
    
      def sign!
        @request.signature=sign
      end
    
      def verify?
        return false unless @request.signed?
        @request.signature==sign
      end
      
      protected
      
      def digest
        digest_class.digest(base_string)
      end
    end
    
    class PLAINTEXT < Base

      def sign
        base_string
      end

      def base_string
        "#{escape(consumer_secret)}&#{escape(token_secret)}"
      end

      private

      def digest; signature_base_string; end
    end
    
    module HashedMessageAuth
      class Base < OAuth::Signature::Base

        private

        def digest
          hmac_class.digest(secret, base_string)
        end

        def secret
          "#{escape(consumer_secret)}&#{escape(token_secret)}"
        end
      end

      class MD5 < Base
        private
        def hmac_class; HMAC::MD5; end
      end

      class RMD160 < Base
        private
        def hmac_class; HMAC::RMD160; end
      end

      class SHA1 < Base
        private
        def hmac_class; HMAC::SHA1; end
      end

      class SHA2 < Base
        private
        def hmac_class; HMAC::SHA1; end
      end
    end

    module RSA
      class SHA1 < OAuth::Signature::Base
        def ==(cmp_signature)
          public_key = OpenSSL::PKey::RSA.new(consumer_secret)
          public_key.verify(OpenSSL::Digest::SHA1.new, cmp_signature, base_string)
        end

        private

        def digest
          private_key = OpenSSL::PKey::RSA.new(consumer_secret)
          private_key.sign(OpenSSL::Digest::SHA1.new, base_string)
        end
      end
    end
    
  end
end
