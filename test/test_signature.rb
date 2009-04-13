require File.dirname(__FILE__) + '/test_helper.rb'

class TestOauth < Test::Unit::TestCase

  def test_parameter_escaping_kcode_invariant
    old = $KCODE
    begin
      %w(n N e E s S u U).each do |kcode|
        $KCODE = kcode
        assert_equal '%E3%81%82', OAuth::Helper.escape('あ'),
                      "Failed to correctly escape Japanese under $KCODE = #{kcode}"
        assert_equal '%C3%A9', OAuth::Helper.escape('é'),
                      "Failed to correctly escape e+acute under $KCODE = #{kcode}"
      end
    ensure
      $KCODE = old
    end
  end
end
