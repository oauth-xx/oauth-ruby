require File.expand_path("../../test_helper", __FILE__)

require "oauth/client"

class ClientHelperTest < Minitest::Test
  def setup
    @consumer = OAuth::Consumer.new(
      "consumer_key_86cad9", "5888bf0345e5d237",
      site: "http://blabla.bla",
      proxy: "http://user:password@proxy.bla:8080",
      request_token_path: "/oauth/example/request_token.php",
      access_token_path: "/oauth/example/access_token.php",
      authorize_path: "/oauth/example/authorize.php",
      scheme: :header,
      http_method: :get
    )
  end

  def test_oauth_parameters_allow_empty_params_default
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_version" => "1.0"
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end

  def test_oauth_parameters_allow_empty_params_true
    input = true
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer,
                                            allow_empty_params: input)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_body_hash" => nil,
          "oauth_callback" => nil,
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_token" => "",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_verifier" => nil,
          "oauth_version" => "1.0",
          "oauth_session_handle" => nil
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end

  def test_oauth_parameters_allow_empty_params_false
    input = false
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer,
                                            allow_empty_params: input)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_version" => "1.0"
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end

  def test_oauth_parameters_allow_empty_params_only_oauth_token_as_string
    input = "oauth_token"
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer,
                                            allow_empty_params: input)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_token" => "",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_version" => "1.0"
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end

  def test_oauth_parameters_allow_empty_params_only_oauth_token_as_array
    input = ["oauth_token"]
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer,
                                            allow_empty_params: input)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_token" => "",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_version" => "1.0"
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end

  def test_oauth_parameters_allow_empty_params_oauth_token_and_oauth_session_handle
    input = %w[oauth_token oauth_session_handle]
    helper = OAuth::Client::Helper.new(nil, consumer: @consumer,
                                            allow_empty_params: input)
    helper.stub :timestamp, "0" do
      helper.stub :nonce, "nonce" do
        expected = {
          "oauth_consumer_key" => "consumer_key_86cad9",
          "oauth_token" => "",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "0",
          "oauth_nonce" => "nonce",
          "oauth_version" => "1.0",
          "oauth_session_handle" => nil
        }
        assert_equal expected, helper.oauth_parameters
      end
    end
  end
end
