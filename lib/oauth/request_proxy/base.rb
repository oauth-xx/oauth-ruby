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
    
    protected
    
    def header_params
      %w( X-HTTP_AUTHORIZATION Authorization HTTP_AUTHORIZATION ).each do |header|
        next unless request.env.include?(header)

        header = request.env[header]
        next unless header[0,6] == 'OAuth '

        oauth_param_string = header[6,header.length].split(/[,=]/)
        oauth_param_string.map! { |v| unescape(v.strip) }
        oauth_param_string.map! { |v| v =~ /^\".*\"$/ ? v[1..-2] : v }
        oauth_params = Hash[*oauth_param_string.flatten]
        oauth_params.reject! { |k,v| k !~ /^oauth_/ }

        return oauth_params
      end

      return {}
    end
    
    def unescape(value)
      URI.unescape(value.gsub('+', '%2B'))
    end
    
  end
end
