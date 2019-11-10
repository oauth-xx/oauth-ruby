require File.expand_path('../../test_helper', __FILE__)

class StubbedToken < OAuth::RequestToken
  define_method :build_url_promoted do |root_domain, params|
    build_url root_domain, params
  end
end

class TestRequestToken < Minitest::Test
  def setup
    # setup a fake req. token. mocking Consumer would be more appropriate...
    @request_token = OAuth::RequestToken.new(
      OAuth::Consumer.new("key", "secret", {}),
      "key",
      "secret"
    )
  end

  def test_request_token_builds_authorize_url_connectly_with_additional_params
    auth_url = @request_token.authorize_url({:oauth_callback => "github.com"})
    assert auth_url
    assert_match(/oauth_token/, auth_url)
    assert_match(/oauth_callback/, auth_url)
  end

  def test_request_token_builds_authorize_url_connectly_with_no_or_nil_params
    # we should only have 1 key in the url returned if we didn't pass anything.
    # this is the only required param to authenticate the client.
    auth_url = @request_token.authorize_url(nil)
    assert auth_url
    assert_match(/\?oauth_token=/, auth_url)

    auth_url = @request_token.authorize_url
    assert auth_url
    assert_match(/\?oauth_token=/, auth_url)
  end

  def test_request_token_returns_nil_authorize_url_when_token_is_nil
    @request_token.token = nil
    assert_nil @request_token.authorize_url
  end

  def test_request_token_builds_authenticate_url_connectly_with_additional_params
    authenticate_url = @request_token.authenticate_url({:oauth_callback => "github.com"})
    assert authenticate_url
    assert_match(/oauth_token/, authenticate_url)
    assert_match(/oauth_callback/, authenticate_url)
  end

  def test_request_token_builds_authenticate_url_connectly_with_no_or_nil_params
    # we should only have 1 key in the url returned if we didn't pass anything.
    # this is the only required param to authenticate the client.
    authenticate_url = @request_token.authenticate_url(nil)
    assert authenticate_url
    assert_match(/\?oauth_token=/, authenticate_url)

    authenticate_url2 = @request_token.authenticate_url
    assert authenticate_url2
    assert_match(/\?oauth_token=/, authenticate_url2)
  end

  def test_request_token_returns_nil_authenticate_url_when_token_is_nil
    @request_token.token = nil
    assert_nil @request_token.authenticate_url
  end

  #TODO: mock out the Consumer to test the Consumer/AccessToken interaction.
  def test_get_access_token
  end

  def test_build_url
   @stubbed_token = StubbedToken.new(nil, nil, nil)
    assert_respond_to @stubbed_token, :build_url_promoted
    url = @stubbed_token.build_url_promoted(
      "http://github.com/oauth/authorize",
      {:foo => "bar bar"})
    assert url
    assert_equal "http://github.com/oauth/authorize?foo=bar+bar", url
  end
end
