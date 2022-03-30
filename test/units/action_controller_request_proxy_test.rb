# frozen_string_literal: true

require_relative "../test_helper"

require "oauth/request_proxy/action_controller_request"

class ActionControllerRequestProxyTest < Minitest::Test
  def request_proxy(request_method = :get, uri_params = {}, body_params = {})
    request = ActionDispatch::TestRequest.create
    request.request_uri = "/"

    case request_method
    when :post
      request.env["REQUEST_METHOD"] = "POST"
    when :put
      request.env["REQUEST_METHOD"] = "PUT"
    when :patch
      request.env["REQUEST_METHOD"] = "PATCH"
    end

    request.env["REQUEST_URI"] = "/"
    request.env["RAW_POST_DATA"] = body_params.to_query
    request.env["QUERY_STRING"] = body_params.to_query
    request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"

    yield request if block_given?
    OAuth::RequestProxy::ActionControllerRequest.new(request, parameters: uri_params)
  end

  def test_that_proxy_simple_get_request_works_with_query_params
    request_proxy = request_proxy(:get, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "GET", request_proxy.method
  end

  def test_that_proxy_simple_post_request_works_with_query_params
    request_proxy = request_proxy(:post, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "POST", request_proxy.method
  end

  def test_that_proxy_simple_put_request_works_with_query_params
    request_proxy = request_proxy(:put, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PUT", request_proxy.method
  end

  def test_that_proxy_simple_patch_request_works_with_query_params
    request_proxy = request_proxy(:patch, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PATCH", request_proxy.method
  end

  def test_that_proxy_simple_get_request_works_with_post_params
    request_proxy = request_proxy(:get, {}, { "key" => "value" })

    expected_parameters = []
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "GET", request_proxy.method
  end

  def test_that_proxy_simple_post_request_works_with_post_params
    request_proxy = request_proxy(:post, {}, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "POST", request_proxy.method
  end

  def test_that_proxy_simple_put_request_works_with_post_params
    request_proxy = request_proxy(:put, {}, { "key" => "value" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PUT", request_proxy.method
  end

  def test_that_proxy_simple_patch_request_works_with_post_params
    request_proxy = request_proxy(:patch, {}, { "key" => "value" })

    expected_parameters = []
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PATCH", request_proxy.method
  end

  def test_that_proxy_simple_get_request_works_with_mixed_params
    request_proxy = request_proxy(:get, { "key" => "value" }, { "key2" => "value2" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "GET", request_proxy.method
  end

  def test_that_proxy_simple_post_request_works_with_mixed_params
    request_proxy = request_proxy(:post, { "key" => "value" }, { "key2" => "value2" })

    expected_parameters = [%w[key value], %w[key2 value2]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "POST", request_proxy.method
  end

  def test_that_proxy_simple_put_request_works_with_mixed_params
    request_proxy = request_proxy(:put, { "key" => "value" }, { "key2" => "value2" })

    expected_parameters = [%w[key value], %w[key2 value2]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PUT", request_proxy.method
  end

  def test_that_proxy_simple_patch_request_works_with_mixed_params
    request_proxy = request_proxy(:patch, { "key" => "value" }, { "key2" => "value2" })

    expected_parameters = [%w[key value]]
    assert_equal expected_parameters, request_proxy.parameters_for_signature
    assert_equal "PATCH", request_proxy.method
  end

  def test_parameter_keys_should_preserve_brackets_from_hash
    assert_equal(
      [["message[body]", "This is a test"]],
      request_proxy(:post, { message: { body: "This is a test" } }).parameters_for_signature
    )
  end

  def test_parameter_values_with_amps_should_not_break_parameter_parsing
    assert_equal(
      [["message[body]", "http://foo.com/?a=b&c=d"]],
      request_proxy(:post, { message: { body: "http://foo.com/?a=b&c=d" } }).parameters_for_signature
    )
  end

  def test_parameter_keys_should_preserve_brackets_from_array
    assert_equal(
      [["foo[]", "123"], ["foo[]", "456"]],
      request_proxy(:post, { foo: [123, 456] }).parameters_for_signature.sort
    )
  end
end
