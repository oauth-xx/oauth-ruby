require 'test/unit'
$LOAD_PATH << File.dirname(__FILE__) + '/../lib/'

begin
  # load redgreen unless running from within TextMate (in which case ANSI
  # color codes mess with the output)
  require 'redgreen' unless ENV['TM_CURRENT_LINE']
rescue LoadError
  nil
end
