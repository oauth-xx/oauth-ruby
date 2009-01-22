require 'oauth/request_proxy/base'

module OAuth
  module RequestProxy
    # RequestProxy for Hashes to facilitate simpler signature creation.
    # Usage:
    #   request = OAuth::RequestProxy.proxy \
    #      "method" => "iq",
    #      "uri"    => [from, to] * "&",
    #      "parameters" => {
    #        "oauth_consumer_key"     => oauth_consumer_key,
    #        "oauth_token"            => oauth_token,
    #        "oauth_signature_method" => "HMAC-SHA1"
    #      }
    #
    #   signature = OAuth::Signature.sign \
    #     request,
    #     :consumer_secret => oauth_consumer_secret,
    #     :token_secret    => oauth_token_secret,
    class MockRequest < OAuth::RequestProxy::Base
      proxies Hash

      def parameters
        @request["parameters"]
      end

      def method
        @request["method"]
      end

      def uri
        @request["uri"]
      end
    end
  end
end
