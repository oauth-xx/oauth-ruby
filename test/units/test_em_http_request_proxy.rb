require File.expand_path("../../test_helper", __FILE__)

begin
  require "em-http"
  require "oauth/request_proxy/em_http_request"

  class EmHttpRequestProxyTest < Minitest::Test
    def test_request_proxy_works_with_simple_request
      proxy = create_request_proxy
      assert_equal({}, proxy.parameters)
  end

    def test_request_proxy_works_with_query_string_params
      assert_equal({ "name" => ["Fred"] }, create_request_proxy(query: "name=Fred").parameters)
      assert_equal({ "name" => ["Fred"] }, create_request_proxy(query: { name: "Fred" }).parameters)
      proxy = create_request_proxy(query: { name: "Fred" }, uri: "http://example.com/?awesome=true")
      assert_equal({ "name" => ["Fred"], "awesome" => ["true"] }, proxy.parameters)
    end

    def test_request_proxy_works_with_post_body_params_with_correct_content_type
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "POST"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "POST", body: "a=1"
      assert_equal({ "a" => ["1"] }, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "POST", body: { "a" => 1 }
      assert_equal({ "a" => ["1"] }, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "PUT"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "PUT", body: "a=1"
      assert_equal({ "a" => ["1"] }, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "PUT", body: { "a" => 1 }
      assert_equal({ "a" => ["1"] }, proxy.parameters)
    end

    def test_request_proxy_ignore_post_body_with_invalid_content_type
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "POST"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "POST", body: "a=1"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "POST", body: { "a" => 1 }
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "PUT"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "PUT", body: "a=1"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "text/plain" }, method: "PUT", body: { "a" => 1 }
      assert_equal({}, proxy.parameters)
    end

    def test_request_proxy_ignores_post_body_with_invalid_method
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "DELETE"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "DELETE", body: "a=1"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "DELETE", body: { "a" => 1 }
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "GET"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "GET", body: "a=1"
      assert_equal({}, proxy.parameters)
      proxy = create_request_proxy head: { "Content-Type" => "application/x-www-form-urlencoded" }, method: "GET", body: { "a" => 1 }
      assert_equal({}, proxy.parameters)
    end

    def test_request_proxy_works_with_argument_params
      assert_equal({ "a" => ["1"] }, create_request_proxy(proxy_options: { parameters: { "a" => "1" } }).parameters)
    end

    def test_request_proxy_works_with_mixed_params
      proxy = create_request_proxy(proxy_options: { parameters: { "a" => "1" } }, query: { "c" => "1" }, uri: "http://example.com/test?b=1")
      assert_equal({ "a" => ["1"], "b" => ["1"], "c" => ["1"] }, proxy.parameters)
      proxy = create_request_proxy(proxy_options: { parameters: { "a" => "1" } }, body: { "b" => "1" }, query: { "c" => "1" },
                                   uri: "http://example.com/test?d=1", method: "POST", head: { "Content-Type" => "application/x-www-form-urlencoded" })
      assert_equal({ "a" => ["1"], "b" => ["1"], "c" => ["1"], "d" => ["1"] }, proxy.parameters)
    end

    def test_request_has_the_correct_uri
      assert_equal "http://example.com/", create_request_proxy.uri
      assert_equal "http://example.com/?a=1", create_request_proxy(query: "a=1").request.normalize_uri.to_s
      assert_equal "http://example.com/?a=1", create_request_proxy(query: { "a" => "1" }).request.normalize_uri.to_s
    end

    def test_request_proxy_has_correct_method
      assert_equal "GET", create_request_proxy(method: "GET").request.req[:method]
      assert_equal "PUT", create_request_proxy(method: "PUT").request.req[:method]
      assert_equal "POST", create_request_proxy(method: "POST").request.req[:method]
      assert_equal "DELETE", create_request_proxy(method: "DELETE").request.req[:method]
    end

    protected

    def create_client(options = {})
      options[:method] = options.key?(:method) ? options[:method].upcase : "GET"
      uri = options.delete(:uri) || "http://example.com/"
      EventMachine::HttpClient.new(URI.parse(uri), options)
    end

    def create_request_proxy(opts = {})
      arguments = opts.delete(:proxy_options) || {}
      OAuth::RequestProxy.proxy(create_client(opts), arguments)
    end
    end
rescue LoadError => e
  warn "! problem loading em-http, skipping these tests: #{e}"
end
