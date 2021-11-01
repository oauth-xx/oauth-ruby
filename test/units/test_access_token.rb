require File.expand_path("../test_helper", __dir__)

class TestAccessToken < Minitest::Test
  def setup
    @fake_response = {
      user_id: 5_734_758_743_895,
      oauth_token: "key",
      oauth_token_secret: "secret"
    }
    # setup a fake req. token. mocking Consumer would be more appropriate...
    @access_token = OAuth::AccessToken.from_hash(
      OAuth::Consumer.new("key", "secret", {}),
      @fake_response
    )
  end

  def test_provides_response_parameters
    assert @access_token
    assert_respond_to @access_token, :params
  end

  def test_access_token_makes_non_oauth_response_params_available
    assert @access_token.params[:user_id]
    assert_equal 5_734_758_743_895, @access_token.params[:user_id]
  end
end
