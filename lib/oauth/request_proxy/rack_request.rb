require 'oauth/request_proxy/base'
require 'uri'
require 'rack'

module OAuth::RequestProxy
  class RackRequest < OAuth::RequestProxy::Base
    proxies Rack::Request

    def method
      request.env["rack.methodoverride.original_method"] || request.request_method
    end

    def uri
      request.url
    end

    def body
      body_string = request.body.read
      #rewind the StringIO so other mehtods can use it as well
      request.body.rewind
      body_string
    end

    def parameters
      if options[:clobber_request]
        options[:parameters] || {}
      else
        params = request_params.merge(query_params).merge(header_params)
        params.merge(options[:parameters] || {})
      end
    end

    def parameters_for_signature
      param_hash = parameters.reject { |k,v| k == "oauth_signature" || unsigned_parameters.include?(k)}
      array_values = param_hash.select {|k,v| v.kind_of?(Array)}
      array_values.each do |k,v|
        param_hash.delete(k)
        param_hash["#{k}[]"] = v
      end
      param_hash
    end
    
    def signature
      parameters['oauth_signature']
    end

  protected

    def query_params
      request.GET
    end

    def request_params
      if request.content_type and request.content_type.to_s.downcase.start_with?("application/x-www-form-urlencoded")
        request.POST
      else
        {}
      end
    end
  end
end
