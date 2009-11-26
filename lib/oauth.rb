$LOAD_PATH << File.dirname(__FILE__) unless $LOAD_PATH.include?(File.dirname(__FILE__))
  
require 'oauth/oauth'
require 'oauth/client/helper'
require 'oauth/signature/hmac/sha1'
require 'oauth/request_proxy/mock_request'
