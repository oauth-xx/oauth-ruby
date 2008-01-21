require 'oauth/request_proxy'

module OAuth::RequestProxy
  class Base
    def self.proxies(klass)
      OAuth::RequestProxy.available_proxies[klass] = self
    end

    attr_accessor :request, :options

    def initialize(request, options = {})
      @request = request
      @options = options
    end

    def token
      parameters['oauth_token']
    end

    def consumer_key
      parameters['oauth_consumer_key']
    end

    def parameters_for_signature
      p = parameters.dup
      p.delete("oauth_signature")
      p
    end

    def nonce
      parameters['oauth_nonce']
    end

    def timestamp
      parameters['oauth_timestamp']
    end

    def signature_method
      case parameters['oauth_signature_method']
      when Array: parameters['oauth_signature_method'].first
      else
        parameters['oauth_signature_method']
      end
    end

    def signature
      parameters['oauth_signature'] || ""
    end
  end
end
