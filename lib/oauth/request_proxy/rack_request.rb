require 'oauth/request_proxy/base'
require 'uri'
require 'rack'

module OAuth::RequestProxy
  class RackRequest < OAuth::RequestProxy::Base
    proxies Rack::Request
    
    def method
      request.request_method
    end
    
    def uri
      uri = URI.parse(request.url)
      uri.query = nil
      uri.to_s
    end

    def parameters
      if options[:clobber_request]
        options[:parameters] || {}
      else
        params = request_params.merge(query_params).merge(header_params)
        params.merge(options[:parameters] || {})
      end
    end
    
    def signature
      parameters['oauth_signature']
    end
    
    protected

    def query_params
      request.GET
    end

    def request_params
      request.params
    end
  end
end