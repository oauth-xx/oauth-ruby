require 'oauth/request_proxy/base'
require 'typhoeus'
require 'typhoeus/request'
require 'uri'
require 'cgi'

module OAuth::RequestProxy::Typhoeus
  class Request < OAuth::RequestProxy::Base
    proxies Typhoeus::Request
    
    def method
      request.method.to_s.upcase
    end
    
    def uri
      options[:uri].to_s
    end
    
    def parameters
        if options[:clobber_request]
          options[:parameters]
        else
          post_parameters.merge(query_parameters).merge(options[:parameters] || {})
        end
      end

    private
    
    def query_parameters
      query = URI.parse(request.url).query
      return(query ? CGI.parse(query) : {})
    end
    
    def post_parameters
      # Post params are only used if posting form data
      if(method == 'POST' && request.headers['Content-Type'] && request.headers['Content-Type'].downcase == 'application/x-www-form-urlencoded')
        request.body || {}
      else
        {}
      end      
    end
  end
end