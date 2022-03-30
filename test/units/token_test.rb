# frozen_string_literal: true

require_relative "../test_helper"

require "oauth/token"

class TokenTest < Minitest::Test
  def setup; end

  def test_token_constructor_produces_valid_token
    token = OAuth::Token.new("xyz", "123")
    assert_equal "xyz", token.token
    assert_equal "123", token.secret
  end
end
