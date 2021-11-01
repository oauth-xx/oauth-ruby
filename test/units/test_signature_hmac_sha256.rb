require File.expand_path("../test_helper", __dir__)

require "oauth/signature/hmac/sha256"

class SignatureHMACSHA256Test < Minitest::Test
  def test_that_verify_returns_true_when_the_request_signature_is_right
    request = OAuth::RequestProxy::MockRequest.new(
      "method" => "POST",
      "uri" => "https://photos.example.net/initialize",
      "parameters" => {
        "oauth_consumer_key" => "dpf43f3p2l4k3l03",
        "oauth_signature_method" => "HMAC-SHA256",
        "oauth_timestamp" => "137131200",
        "oauth_nonce" => "wIjqoS",
        "oauth_callback" => "http://printer.example.com/ready",
        "oauth_version" => "1.0",
        "oauth_signature" => "tkpCGNHi3laWBHQ9+Ka5IOeixEuhxg12LTMlLJxQxKc="
      }
    )
    assert OAuth::Signature::HMAC::SHA256.new(request, consumer_secret: "kd94hf93k423kf44").verify
  end

  def test_that_verify_returns_false_when_the_request_signature_is_wrong
    # Test a bug in the OAuth::Signature::Base#== method: when the Base64.decode64 method is
    # used on the "self" and "other" signature (as in version 0.4.7), the result may be incorrectly "true".
    request = OAuth::RequestProxy::MockRequest.new(
      "method" => "POST",
      "uri" => "https://photos.example.net/initialize",
      "parameters" => {
        "oauth_consumer_key" => "dpf43f3p2l4k3l03",
        "oauth_signature_method" => "HMAC-SHA256",
        "oauth_timestamp" => "137131200",
        "oauth_nonce" => "wIjqoS",
        "oauth_callback" => "http://printer.example.com/ready",
        "oauth_version" => "1.0",
        "oauth_signature" => "tkpCGNHi3laWBHQ9+Ka5IOeixEuhxg12LTMlLJxQxKZ="
      }
    )
    refute OAuth::Signature::HMAC::SHA256.new(request, consumer_secret: "kd94hf93k423kf44").verify
  end
end
