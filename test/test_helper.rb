require 'test/unit'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'
require 'oauth'

# require File.dirname(__FILE__) + '/../lib/oauth'

begin
  # load redgreen unless running from within TextMate (in which case ANSI
  # color codes mess with the output)
  require 'redgreen' unless ENV['TM_CURRENT_LINE']
rescue LoadError
  nil
end
