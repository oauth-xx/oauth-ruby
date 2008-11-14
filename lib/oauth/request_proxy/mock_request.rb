require 'oauth/request_proxy/base'

module OAuth
  module RequestProxy
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
