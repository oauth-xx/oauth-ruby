require File.dirname(__FILE__) + '/test_helper.rb'
require 'oauth/helper'

class TestOAuthHelper < Test::Unit::TestCase

  def test_parse_valid_header
    header = 'OAuth ' \
             'realm="http://example.com/method", ' \
             'oauth_consumer_key="vince_clortho", ' \
             'oauth_token="token_value", ' \
             'oauth_signature_method="HMAC-SHA1", ' \
             'oauth_signature="signature_here", ' \
             'oauth_timestamp="1240004133", oauth_nonce="nonce", ' \
             'oauth_version="1.0" '

    params = OAuth::Helper.parse_header(header)

    assert_equal "http://example.com/method", params['realm']
  end

  def test_parse_header_ill_formed
    header = "OAuth garbage"

    assert_raise OAuth::Problem do
      OAuth::Helper.parse_header(header)
    end
  end

  def test_parse_header_contains_equals
    header = 'OAuth ' \
             'realm="http://example.com/method", ' \
             'oauth_consumer_key="vince_clortho", ' \
             'oauth_token="token_value", ' \
             'oauth_signature_method="HMAC-SHA1", ' \
             'oauth_signature="signature_here_with_=", ' \
             'oauth_timestamp="1240004133", oauth_nonce="nonce", ' \
             'oauth_version="1.0" '

    assert_raise OAuth::Problem do
      OAuth::Helper.parse_header(header)
    end
  end
end
