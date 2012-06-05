require 'active_support'
require 'action_controller'
require 'action_controller/request'
require 'uri'

module OAuth::RequestProxy
  class ActionControllerRequest < OAuth::RequestProxy::Base
    proxies(defined?(ActionController::AbstractRequest) ? ActionController::AbstractRequest : ActionController::Request)

    def method
      request.method.to_s.upcase
    end

    def uri
      request.url
    end

    def parameters
      if options[:clobber_request]
        options[:parameters] || {}
      else
        params = request_params.merge(query_params).merge(header_params)
        params.stringify_keys! if params.respond_to?(:stringify_keys!)
        params.merge(options[:parameters] || {})
      end
    end

    # Override from OAuth::RequestProxy::Base to avoid roundtrip
    # conversion to Hash or Array and thus preserve the original
    # parameter names
    def parameters_for_signature
      params = []
      params << options[:parameters].to_query if options[:parameters]

      unless options[:clobber_request]
        params << header_params.to_query
        params << request.query_string unless query_string_blank?

        if request.post? && request.content_type.to_s.downcase.start_with?("application/x-www-form-urlencoded")
          params << request.raw_post
        end
      end

      params.
        join('&').split('&').
        reject(&:blank?).
        map { |p| p.split('=').map{|esc| CGI.unescape(esc)} }.
        reject { |kv| kv[0] == 'oauth_signature'}
    end

  protected

    def query_params
      request.query_parameters
    end

    def request_params
      request.request_parameters
    end

  end
end

module ActionController
  class Base
    def process_with_oauth(request, response=nil)
      request.apply_oauth! if request.respond_to?(:apply_oauth!)
      process_without_oauth(request, response)
    end
    alias_method_chain :process, :oauth
  end

  class TestRequest
    def self.use_oauth=(bool)
      @use_oauth = bool
    end

    def self.use_oauth?
      @use_oauth
    end

    def configure_oauth(consumer = nil, token = nil, options = {})
      @oauth_options = { :consumer  => consumer,
                         :token     => token,
                         :scheme    => 'header',
                         :signature_method => nil,
                         :nonce     => nil,
                         :timestamp => nil }.merge(options)
    end

    def apply_oauth!
      return unless ActionController::TestRequest.use_oauth? && @oauth_options

      @oauth_helper = OAuth::Client::Helper.new(self, @oauth_options.merge(:request_uri => (respond_to?(:fullpath) ? fullpath : request_uri)))
      @oauth_helper.amend_user_agent_header(env)

      self.send("set_oauth_#{@oauth_options[:scheme]}")
    end

    def set_oauth_header
      env['Authorization'] = @oauth_helper.header
    end

    def set_oauth_parameters
      @query_parameters = @oauth_helper.parameters_with_oauth
      @query_parameters.merge!(:oauth_signature => @oauth_helper.signature)
    end

    def set_oauth_query_string
    end
  end
end