require File.expand_path('../test_helper', __FILE__)

begin
  require 'oauth/request_proxy/rest_client_request'
  require 'rest-client'

  class RestlClientRequestProxyTest < Minitest::Test

    def test_that_proxy_simple_get_request_works
      request = ::RestClient::Request.new(method: :get, url: "http://example.com/test?key=value")
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test?key=value'})

      expected_parameters = {'key' => ['value']}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'GET', request_proxy.method
    end

    def test_that_proxy_simple_post_request_works_with_arguments
      request = ::RestClient::Request.new(method: :post, url: "http://example.com/test")
      params = {'key' => 'value'}
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test', :parameters => params})

      expected_parameters = {'key' => 'value'}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'POST', request_proxy.method
    end

    def test_that_proxy_simple_post_request_works_with_form_data
      request = ::RestClient::Request.new(method: :post, url: "http://example.com/test",
        payload: {'key' => 'value'},
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'})
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test'})

      expected_parameters = {'key' => 'value'}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'POST', request_proxy.method
    end

    def test_that_proxy_simple_put_request_works_with_arguments
      request = ::RestClient::Request.new(method: :put, url: "http://example.com/test")
      params = {'key' => 'value'}
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test', :parameters => params})

      expected_parameters = {'key' => 'value'}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'PUT', request_proxy.method
    end

    def test_that_proxy_simple_put_request_works_with_form_data
      request = ::RestClient::Request.new(method: :put, url: "http://example.com/test",
        payload: {'key' => 'value'},
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'})
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test'})

      expected_parameters = {'key' => 'value'}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'PUT', request_proxy.method
    end

    def test_that_proxy_post_request_works_with_mixed_parameter_sources
      request = ::RestClient::Request.new(url: 'http://example.com/test?key=value',
        method: :post,
        payload: {'key2' => 'value2'},
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'})
      request_proxy = OAuth::RequestProxy.proxy(request, {:uri => 'http://example.com/test?key=value', :parameters => {'key3' => 'value3'}})

      expected_parameters = {'key' => ['value'], 'key2' => 'value2', 'key3' => 'value3'}
      assert_equal expected_parameters, request_proxy.parameters_for_signature
      assert_equal 'http://example.com/test', request_proxy.normalized_uri
      assert_equal 'POST', request_proxy.method
    end

  end
rescue LoadError => e
    warn "! problem loading rest-client, skipping these tests: #{e}"
end
