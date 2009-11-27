require 'test/unit'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'
require 'oauth'

# require File.dirname(__FILE__) + '/../lib/oauth'

# begin
#   # load redgreen unless running from within TextMate (in which case ANSI
#   # color codes mess with the output)
#   require 'redgreen' unless ENV['TM_CURRENT_LINE']
# rescue LoadError
#   nil
# end

class Test::Unit::TestCase
  
  def assert_matching_headers(expected, actual)
    # transform into sorted arrays
    expected = expected.split(/(,|\s)/).reject {|v| v == '' || v =~ /^[\,\s]+/}.sort
    actual   = actual.split(/(,|\s)/).reject {|v| v == '' || v =~ /^[\,\s]+/}.sort
    assert_equal expected, actual
  end
  
end