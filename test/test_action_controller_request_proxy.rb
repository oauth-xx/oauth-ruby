require File.dirname(__FILE__) + '/test_helper.rb'
require 'oauth/request_proxy/action_controller_request.rb'
require 'action_controller'
require 'action_controller/test_process'

class ActionControllerRequestProxyTest < Test::Unit::TestCase

  def request_proxy(parameters={})
    request = ActionController::TestRequest.new({}, parameters)
    request.env['CONTENT_TYPE'] = 'application/x-www-form-urlencoded'
    yield request if block_given?
    OAuth::RequestProxy.proxy(request)
  end
 
  def test_parameter_keys_should_preserve_brackets_from_hash
    assert_equal(
      [["message[body]", "This is a test"]],
      request_proxy({ :message => { :body => 'This is a test' }}).parameters_for_signature
    )
  end

  def test_parameter_keys_should_preserve_brackets_from_array
    assert_equal(
      [["foo[]", "123"], ["foo[]", "456"]],
      request_proxy({ :foo => [123, 456] }).parameters_for_signature.sort
    )
  end
end
