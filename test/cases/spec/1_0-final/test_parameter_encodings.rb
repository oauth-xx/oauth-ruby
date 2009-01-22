require File.dirname(__FILE__) + '/../../oauth_case'

# See http://oauth.net/core/1.0/#encoding_parameters
#
# 5.1.  Parameter Encoding
# 
# All parameter names and values are escaped using the [RFC3986] percent-encoding (%xx) mechanism. 
# Characters not in the unreserved character set ([RFC3986] section 2.3) MUST be encoded. Characters 
# in the unreserved character set MUST NOT be encoded. Hexadecimal characters in encodings MUST be 
# upper case. Text names and values MUST be encoded as UTF-8 octets before percent-encoding them per [RFC3629].
# 
#   unreserved = ALPHA, DIGIT, '-', '.', '_', '~'
# 

class ParameterEncodingTest < OAuthCase
  include OAuth::Helper
  
  def test_encodings_alpha_num
    assert_encoding('abcABC123','abcABC123')
  end
  
  def test_encodings_non_escaped
    assert_encoding('-._~','-._~')
  end

  def test_encodings_percent
    assert_encoding('%25','%')
  end

  def test_encodings_plus
    assert_encoding('%2B','+')
  end

  def test_encodings_query_param_symbols
    assert_encoding('%26%3D%2A','&=*')
  end
  
  protected
  
  
  def assert_encoding(expected,given,message=nil)
    assert_equal expected,escape(given) , message
  end
  
end