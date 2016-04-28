require 'rubygems'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require 'byebug'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'
require 'oauth'
require 'stringio'
require 'webmock/minitest'

require 'support/minitest_helpers'
