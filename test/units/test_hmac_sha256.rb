require File.expand_path("../test_helper", __dir__)

class TestSignatureHmacSha256 < Minitest::Test
  def test_that_hmac_sha256_implements_hmac_sha256
    assert_includes OAuth::Signature.available_methods, "hmac-sha256"
  end

  def test_that_get_request_from_oauth_test_cases_produces_matching_signature
    request = Net::HTTP::Get.new("/photos?file=vacation.jpg&size=original&oauth_version=1.0&oauth_consumer_key=dpf43f3p2l4k3l03&oauth_token=nnch734d00sl2jdk&oauth_timestamp=1191242096&oauth_nonce=kllo9940pd9333jh&oauth_signature_method=HMAC-SHA256")

    consumer = OAuth::Consumer.new("dpf43f3p2l4k3l03", "kd94hf93k423kf44")
    token = OAuth::Token.new("nnch734d00sl2jdk", "pfkkdhi9sl3r4s00")

    signature = OAuth::Signature.sign(request, { consumer: consumer,
                                                 token: token,
                                                 uri: "http://photos.example.net/photos",
                                                 signature_method: "HMAC-SHA256" })

    assert_equal "WVPzl1j6ZsnkIjWr7e3OZ3jkenL57KwaLFhYsroX1hg=", signature
  end
end
