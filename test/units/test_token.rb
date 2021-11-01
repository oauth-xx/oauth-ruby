# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

require "oauth/token"

class TestToken < Minitest::Test
  def setup; end

  def test_token_constructor_produces_valid_token
    token = OAuth::Token.new("xyz", "123")
    assert_equal "xyz", token.token
    assert_equal "123", token.secret
  end
end
