require 'test/unit'
require 'oauth/signature'
require 'oauth/request_proxy/mock_request'


class OAuthCase < Test::Unit::TestCase
  
  protected
  
  # Creates a fake request
  def request(params={},method='GET',uri="http://photos.example.net/photos")
    OAuth::RequestProxy.proxy({'parameters'=>params,'method'=>method,'uri'=>uri})
  end
end