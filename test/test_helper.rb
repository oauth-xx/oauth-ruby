require 'test/unit'
require 'rubygems'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'
require 'oauth'
require 'mocha'
require 'stringio'
require 'webmock/test_unit'

class TestHelper < Test::Unit::TestCase
  def assert_matching_headers(expected, actual)
    # transform into sorted arrays
    auth_intro, auth_params = actual.split(' ', 2)
    assert_equal auth_intro, 'OAuth'
    expected    = expected.split(/(,|\s)/).reject {|v| v == '' || v =~ /^[\,\s]+/}.sort
    auth_params = auth_params.split(/(,|\s)/).reject {|v| v == '' || v =~ /^[\,\s]+/}.sort
    assert_equal expected, auth_params
  end

  def stub_test_ie
    stub_request(:any, "http://term.ie/oauth/example/request_token.php").to_return(:body => "oauth_token=requestkey&oauth_token_secret=requestsecret")
    stub_request(:post, "http://term.ie/oauth/example/access_token.php").to_return(:body => "oauth_token=accesskey&oauth_token_secret=accesssecret")
    stub_request(:get, %r{http://term\.ie/oauth/example/echo_api\.php\?.+}).to_return(lambda {|request| {:body => request.uri.query}})
    stub_request(:post, "http://term.ie/oauth/example/echo_api.php").to_return(lambda {|request| {:body => request.body}})
  end
  
  def test_normalize
	# test array
	assert_equal OAuth::Helper::normalize([["one",1],["two",2]]), "one=1&two=2"
	
	# test hash and sorting
	assert_equal OAuth::Helper::normalize([["car",{"volvo" => 1, "saab" => 2}]]), "car%5Bsaab%5D=2&car%5Bvolvo%5D=1"
  end
end
