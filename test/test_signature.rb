# -*- encoding: utf-8 -*-

require File.expand_path('../test_helper', __FILE__)

class TestOauth < Minitest::Test

  def test_parameter_escaping_kcode_invariant
    %w(n N e E s S u U).each do |kcode|
      assert_equal '%E3%81%82', OAuth::Helper.escape('あ'),
                    "Failed to correctly escape Japanese under $KCODE = #{kcode}"
      assert_equal '%C3%A9', OAuth::Helper.escape('é'),
                    "Failed to correctly escape e+acute under $KCODE = #{kcode}"
    end
  end
end
