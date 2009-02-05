require 'oauth/request_proxy'
require 'oauth/helper'

module OAuth::RequestProxy
  class Base
    include OAuth::Helper

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
      parameters.reject { |k,v| k == "oauth_signature" }
    end

    def oauth_parameters
      parameters.select { |k,v| OAuth::PARAMETERS.include?(k) }.reject { |k,v| v == "" }
    end

    def nonce
      parameters['oauth_nonce']
    end

    def timestamp
      parameters['oauth_timestamp']
    end

    def signature_method
      case parameters['oauth_signature_method']
      when Array
        parameters['oauth_signature_method'].first
      else
        parameters['oauth_signature_method']
      end
    end

    def signature
      parameters['oauth_signature'] || ""
    end

    # See 9.1.2 in specs
    def normalized_uri
      u = URI.parse(uri)
      "#{u.scheme.downcase}://#{u.host.downcase}#{(u.scheme.downcase == 'http' && u.port != 80) || (u.scheme.downcase == 'https' && u.port != 443) ? ":#{u.port}" : ""}#{(u.path && u.path != '') ? u.path : '/'}"
    end

    # See 9.1.1. in specs Normalize Request Parameters
    def normalized_parameters
      normalize(parameters_for_signature)
    end

    def sign(options = {})
      OAuth::Signature.sign(self, options)
    end

    def sign!(options = {})
      parameters["oauth_signature"] = sign(options)
      @signed = true
      signature
    end

    # See 9.1 in specs
    def signature_base_string
      base = [method, normalized_uri, normalized_parameters]
      base.map { |v| escape(v) }.join("&")
    end

    # Has this request been signed yet?
    def signed?
      @signed
    end

    # URI, including OAuth parameters
    def signed_uri
      if signed?
        [uri, normalize(parameters)] * "?"
      else
        STDERR.puts "This request has not yet been signed!"
      end
    end

    # Authorization header for OAuth
    def oauth_header(options = {})
      header_params_str = oauth_parameters.map { |k,v| "#{k}=\"#{escape(v)}\"" }.join(', ')

      realm = "realm=\"#{options[:realm]}\", " if options[:realm]
      "OAuth #{realm}#{header_params_str}"
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
  end
end
