# ensure test env

ENV['RACK_ENV'] = 'test'

# simplecov, Travis will call codeclimate

require 'simplecov'
SimpleCov.start

# require third-party code

require 'byebug'
require 'stringio'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'rack/test'
require 'webmock/minitest'

# require our lib

$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'
require 'oauth'

# require our support code

require 'support/minitest_helpers'
