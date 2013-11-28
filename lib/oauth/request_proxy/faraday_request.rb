require 'oauth/request_proxy/base'
require 'faraday'
require 'uri'
require 'cgi'

module OAuth::RequestProxy::Faraday
  module HTTP
    class HTTPRequest < OAuth::RequestProxy::Base
      proxies ::Faraday::Request

      def method
        request.method.to_s.upcase
      end

      def uri
        options[:uri].to_s
      end

      def parameters
        options[:parameters] ||= {}
        format_params(request.params.to_h.merge(options[:parameters]))
      end

      def body
        request.body
      end

    private

      def format_params(params)
        res = {}
        params.each do |k,v|
          res[k] = v.is_a?(Array) ? v : [v]
        end
        res
      end

      def query_string
        params = [ query_params, auth_header_params ]
        params << post_params if (method.to_s.upcase == 'POST' || method.to_s.upcase == 'PUT') && form_url_encoded?
        params.compact.join('&')
      end

      def form_url_encoded?
        request.headers['Content-Type'] != nil && request.params['Content-Type'].to_s.downcase.start_with?('application/x-www-form-urlencoded')
      end

      def query_params
        URI.parse(request.path).query
      end

      def post_params
        request.body
      end

      def auth_header_params
        return nil unless request['Authorization'] && request['Authorization'][0,5] == 'OAuth'
        auth_params = request['Authorization']
      end
    end
  end
end
