require 'oauth/helper'
require 'oauth/client/helper'
require 'oauth/request_proxy/net_http'

class Net::HTTPRequest
  include OAuth::Helper

  attr_reader :oauth_helper

  # Add the OAuth information to an HTTP request. Depending on the <tt>options[:scheme]</tt> setting
  # this may add a header, additional query string parameters, or additional POST body parameters.
  # The default scheme is +header+, in which the OAuth parameters as put into the +Authorization+
  # header.
  # 
  # * http - Configured Net::HTTP instance
  # * consumer - OAuth::Consumer instance
  # * token - OAuth::Token instance
  # * options - Request-specific options (e.g. +request_uri+, +consumer+, +token+, +scheme+,
  #   +signature_method+, +nonce+, +timestamp+)
  #
  # This method also modifies the <tt>User-Agent</tt> header to add the OAuth gem version.
  #
  # See Also: {OAuth core spec version 1.0, section 5.4.1}[http://oauth.net/core/1.0#rfc.section.5.4.1]
  def oauth!(http, consumer = nil, token = nil, options = {})
    options = { :request_uri      => oauth_full_request_uri(http),
                :consumer         => consumer,
                :token            => token,
                :scheme           => 'header',
                :signature_method => nil,
                :nonce            => nil,
                :timestamp        => nil }.merge(options)

    @oauth_helper = OAuth::Client::Helper.new(self, options)
    @oauth_helper.amend_user_agent_header(self)
    self.send("set_oauth_#{options[:scheme]}")
  end

  # Create a string suitable for signing for an HTTP request. This process involves parameter
  # normalization as specified in the OAuth specification. The exact normalization also depends
  # on the <tt>options[:scheme]</tt> being used so this must match what will be used for the request
  # itself. The default scheme is +header+, in which the OAuth parameters as put into the +Authorization+
  # header.
  # 
  # * http - Configured Net::HTTP instance
  # * consumer - OAuth::Consumer instance
  # * token - OAuth::Token instance
  # * options - Request-specific options (e.g. +request_uri+, +consumer+, +token+, +scheme+,
  #   +signature_method+, +nonce+, +timestamp+)
  # 
  # See Also: {OAuth core spec version 1.0, section 9.1.1}[http://oauth.net/core/1.0#rfc.section.9.1.1]
  def signature_base_string(http, consumer = nil, token = nil, options = {})
    options = { :request_uri      => oauth_full_request_uri(http),
                :consumer         => consumer,
                :token            => token,
                :scheme           => 'header',
                :signature_method => nil,
                :nonce            => nil,
                :timestamp        => nil }.merge(options)

    OAuth::Client::Helper.new(self, options).signature_base_string
  end

private

  def oauth_full_request_uri(http)
    uri = URI.parse(self.path)
    uri.host = http.address
    uri.port = http.port

    if http.respond_to?(:use_ssl?) && http.use_ssl?
      uri.scheme = "https"
    else
      uri.scheme = "http"
    end

    uri.to_s
  end

  def set_oauth_header
    self['Authorization'] = @oauth_helper.header
  end

  # FIXME: if you're using a POST body and query string parameters, using this
  # method will convert those parameters on the query string into parameters in
  # the body. this is broken, and should be fixed.
  def set_oauth_body
    self.set_form_data(@oauth_helper.parameters_with_oauth)
    params_with_sig = @oauth_helper.parameters.merge(:oauth_signature => @oauth_helper.signature)
    self.set_form_data(params_with_sig)
  end

  def set_oauth_query_string
    oauth_params_str = @oauth_helper.oauth_parameters.map { |k,v| [escape(k), escape(v)] * "=" }.join("&")

    uri = URI.parse(path)
    if uri.query.to_s == ""
      uri.query = oauth_params_str
    else
      uri.query = uri.query + "&" + oauth_params_str
    end

    @path = uri.to_s

    @path << "&oauth_signature=#{escape(oauth_helper.signature)}"
  end
end
