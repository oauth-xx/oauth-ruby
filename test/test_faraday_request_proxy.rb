require File.expand_path('../test_helper', __FILE__)

begin

require 'oauth/request_proxy/faraday_request'
require 'faraday'

class FaradayRequestProxyTest < Test::Unit::TestCase

  BASE_URL = 'http://example.com'

  def connection
    unless @connection
      middleware = Faraday::Builder.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.adapter Faraday.default_adapter
      end

      @connection = Faraday.new(BASE_URL, {:builder => middleware})
    end

    @connection
  end

  def test_that_proxy_simple_get_request_works
    request = Faraday::Request.create('GET') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.url "#{BASE_URL}/test?key=value"
    end
    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test?key=value"})

    expected_parameters = {'key' => ['value']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'GET', request_proxy.method
  end

  def test_that_proxy_simple_post_request_works_with_arguments
    request = Faraday::Request.create('POST') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.params['key'] = 'value'
      request.url "#{BASE_URL}/test"
    end

    params = {'key' => 'value'}
    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test", :parameters => params})

    expected_parameters = {'key' => ['value']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'POST', request_proxy.method
  end

  def test_that_proxy_simple_post_request_works_with_form_data
    request = Faraday::Request.create('POST') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.params['key'] = 'value'
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      request.url "#{BASE_URL}/test"
    end

    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test"})

    expected_parameters = {'key' => ['value']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'POST', request_proxy.method
  end

  def test_that_proxy_simple_put_request_works_with_arguments
    request = Faraday::Request.create('PUT') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.url "#{BASE_URL}/test?key=value"
    end

    params = {'key' => 'value'}
    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test", :parameters => params})

    expected_parameters = {'key' => ['value']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'PUT', request_proxy.method
  end

  def test_that_proxy_simple_put_request_works_with_form_data
    request = Faraday::Request.create('PUT') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.params['key'] = 'value'
      request.url "#{BASE_URL}/test"
    end

    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test"})

    expected_parameters = {'key' => ['value']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'PUT', request_proxy.method
  end

  def test_that_proxy_post_request_works_with_mixed_parameter_sources
    request = Faraday::Request.create('POST') do |request|
      request.params = Faraday::Utils::ParamsHash.new
      request.headers = Faraday::Utils::Headers.new
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      request.params['key2'] = 'value2'
      request.url "#{BASE_URL}/test?key=value"
    end
    request_proxy = OAuth::RequestProxy.proxy(request, {:uri => "#{BASE_URL}/test?key=value", :parameters => {'key3' => 'value3'}})

    expected_parameters = {'key' => ['value'], 'key2' => ['value2'], 'key3' => ['value3']}
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "#{BASE_URL}/test", request_proxy.normalized_uri
    assert_equal 'POST', request_proxy.method
  end
end

rescue LoadError => e
  warn "! problem loading faraday, skipping these tests: #{e}"
end
