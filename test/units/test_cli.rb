require File.expand_path('../../test_helper', __FILE__)

require 'oauth/cli'

class TestCLI < Minitest::Test

  def test_parse
    assert_equal 'version', parse('-v')
    assert_equal 'version', parse('--version')

    assert_equal 'help', parse('-h')
    assert_equal 'help', parse('--help')
    assert_equal 'help', parse('-H')
    assert_equal 'help', parse('--HELP')

    assert_equal 'help', parse('')
    assert_equal 'help', parse(nil)

    assert_equal 'help', parse('NotACommand')

    assert_equal 'help'      , parse('h')
    assert_equal 'version'   , parse('v')
    assert_equal 'query'     , parse('q')
    assert_equal 'authorize' , parse('a')
    assert_equal 'sign'      , parse('s')

    assert_equal 'help'      , parse('help')
    assert_equal 'version'   , parse('version')
    assert_equal 'query'     , parse('query')
    assert_equal 'authorize' , parse('authorize')
    assert_equal 'sign'      , parse('sign')

    assert_equal 'help'      , parse('H')
    assert_equal 'version'   , parse('V')
    assert_equal 'query'     , parse('Q')
    assert_equal 'authorize' , parse('A')
    assert_equal 'sign'      , parse('S')

    assert_equal 'help'      , parse('HELP')
    assert_equal 'version'   , parse('VERSION')
    assert_equal 'query'     , parse('QUERY')
    assert_equal 'authorize' , parse('AUTHORIZE')
    assert_equal 'sign'      , parse('SIGN')
  end

  def test_help_empty
    out = run_command

    assert_match(/Usage: /, out)
  end

  def test_help
    out = run_command(%w[help])

    assert_match(/Usage: /, out)
  end

  def test_version
    out = run_command(%w[version])

    assert_equal "OAuth Gem #{OAuth::VERSION}\n", out
  end

  def test_query_empty
    out = run_command(%w[query])

    assert_equal help_output, out
  end

  def test_sign_empty
    out = run_command(%w[sign])

    assert_equal help_output, out
  end

  def test_authorize_empty
    out = run_command(%w[authorize])

    assert_equal help_output, out
  end

  def test_query
    consumer     = Minitest::Mock.new
    access_token = MiniTest::Mock.new
    response     = MiniTest::Mock.new

    consumer_new = lambda { |oauth_consumer_key, oauth_consumer_secret, options|
      expected_options = {:scheme=>:header}
      assert_equal 'oauth_consumer_key', oauth_consumer_key
      assert_equal 'oauth_consumer_secret', oauth_consumer_secret
      assert_equal expected_options, options
      consumer
    }
    access_token_new = lambda { |consumer1, token, secret|
      assert_equal consumer1.object_id, consumer.object_id
      assert_equal 'TOKEN', token
      assert_equal 'SECRET', secret
      access_token
    }

    # mock expects:
    #                    method      return    arguments
    #-------------------------------------------------------------
    response.expect(    :code    , '!code!')
    response.expect(    :message , '!message!')
    response.expect(    :body    , '!body!')
    access_token.expect(:request , response     , [:post, "http://example.com/oauth/url?oauth_consumer_key=oauth_consumer_key&oauth_nonce=GENERATE_KEY&oauth_timestamp=GENERATE_TIMESTAMP&oauth_token=TOKEN&oauth_signature_method=HMAC-SHA1&oauth_version=1.0"])

    OAuth::Helper.stub(:generate_key, 'GENERATE_KEY') do
      OAuth::Helper.stub(:generate_timestamp, 'GENERATE_TIMESTAMP') do
        OAuth::AccessToken.stub(:new, access_token_new) do
          OAuth::Consumer.stub(:new, consumer_new) do
            out = run_command %w[query
              --consumer-key oauth_consumer_key
              --consumer-secret oauth_consumer_secret
              --token TOKEN
              --secret SECRET
              --uri http://example.com/oauth/url
            ]

            assert_equal out, <<-EXPECTED
http://example.com/oauth/url?oauth_consumer_key=oauth_consumer_key&oauth_nonce=GENERATE_KEY&oauth_timestamp=GENERATE_TIMESTAMP&oauth_token=TOKEN&oauth_signature_method=HMAC-SHA1&oauth_version=1.0
!code! !message!
!body!
EXPECTED
          end
        end
      end
    end
  end

  def test_authorize
    access_token  = MiniTest::Mock.new
    consumer      = MiniTest::Mock.new
    request_token = MiniTest::Mock.new

    consumer_new = lambda { |oauth_consumer_key, oauth_consumer_secret, options|
      expected_options = {:access_token_url=>nil, :authorize_url=>nil, :request_token_url=>nil, :scheme=>:header, :http_method=>:get}
      assert_equal 'oauth_consumer_key', oauth_consumer_key
      assert_equal 'oauth_consumer_secret', oauth_consumer_secret
      assert_equal expected_options, options
      consumer
    }

    # mock expects:
    #                      method                return           arguments
    #----------------------------------------------------------------------
    access_token.expect(  :params              , {})
    consumer.expect(      :get_request_token   , request_token , [{:oauth_callback=>nil} , {}])
    request_token.expect( :callback_confirmed? , false)
    request_token.expect( :authorize_url       , "!url1!")
    request_token.expect( :get_access_token    , access_token,   [{:oauth_verifier=>nil}])

    OAuth::Helper.stub(:generate_key, 'GENERATE_KEY') do
      OAuth::Helper.stub(:generate_timestamp, 'GENERATE_TIMESTAMP') do
        OAuth::Consumer.stub(:new, consumer_new) do

          out = run_command %w[authorize
            --consumer-key oauth_consumer_key
            --consumer-secret oauth_consumer_secret
            --method GET
            --uri http://example.com/oauth/url
            ]

          assert_equal out, <<-EXPECTED
Please visit this url to authorize:
!url1!
Press return to continue...
Response:
EXPECTED
        end
      end
    end
  end

  def test_sign
    access_token  = MiniTest::Mock.new
    consumer      = MiniTest::Mock.new
    request_token = MiniTest::Mock.new

    consumer_new = lambda { |oauth_consumer_key, oauth_consumer_secret, options|
      expected_options = {:access_token_url=>nil, :authorize_url=>nil, :request_token_url=>nil, :scheme=>:header, :http_method=>:get}
      assert_equal 'oauth_consumer_key', oauth_consumer_key
      assert_equal 'oauth_consumer_secret', oauth_consumer_secret
      assert_equal expected_options, options
      consumer
    }

    # mock expects:
    #                      method                return           arguments
    #----------------------------------------------------------------------
    access_token.expect(  :params              , {})
    consumer.expect(      :get_request_token   , request_token , [{:oauth_callback=>nil} , {}])
    request_token.expect( :callback_confirmed? , false)
    request_token.expect( :authorize_url       , "!url1!")
    request_token.expect( :get_access_token    , access_token,   [{:oauth_verifier=>nil}])

    out = []

    OAuth::Helper.stub(:generate_key, 'GENERATE_KEY') do
      OAuth::Helper.stub(:generate_timestamp, 'GENERATE_TIMESTAMP') do
        OAuth::Consumer.stub(:new, consumer_new) do

          out.push run_command %w[sign
            --consumer-key oauth_consumer_key
            --consumer-secret oauth_consumer_secret
            --method GET
            --token TOKEN
            --secret SECRET
            --uri http://example.com/oauth/url
            -v
            ]

          out.push run_command %w[sign
            --consumer-key oauth_consumer_key
            --consumer-secret oauth_consumer_secret
            --method GET
            --token TOKEN
            --secret SECRET
            --uri http://example.com/oauth/url
            ]
        end
      end
    end

    assert_equal out.pop, <<-EXPECTED
MujZyJYT5ix2s388yF8sExvPIgA=
EXPECTED

    assert_equal out.pop, <<-EXPECTED
OAuth parameters:
  oauth_consumer_key: oauth_consumer_key
  oauth_nonce: GENERATE_KEY
  oauth_timestamp: GENERATE_TIMESTAMP
  oauth_token: TOKEN
  oauth_signature_method: HMAC-SHA1
  oauth_version: 1.0

Method: GET
URI: http://example.com/oauth/url
Normalized params: oauth_consumer_key=oauth_consumer_key&oauth_nonce=GENERATE_KEY&oauth_signature_method=HMAC-SHA1&oauth_timestamp=GENERATE_TIMESTAMP&oauth_token=TOKEN&oauth_version=1.0
Signature base string: GET&http%3A%2F%2Fexample.com%2Foauth%2Furl&oauth_consumer_key%3Doauth_consumer_key%26oauth_nonce%3DGENERATE_KEY%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3DGENERATE_TIMESTAMP%26oauth_token%3DTOKEN%26oauth_version%3D1.0
OAuth Request URI: http://example.com/oauth/url?oauth_consumer_key=oauth_consumer_key&oauth_nonce=GENERATE_KEY&oauth_signature=MujZyJYT5ix2s388yF8sExvPIgA%3D&oauth_signature_method=HMAC-SHA1&oauth_timestamp=GENERATE_TIMESTAMP&oauth_token=TOKEN&oauth_version=1.0
Request URI: http://example.com/oauth/url?
Authorization header: OAuth oauth_consumer_key=\"oauth_consumer_key\", oauth_nonce=\"GENERATE_KEY\", oauth_timestamp=\"GENERATE_TIMESTAMP\", oauth_token=\"TOKEN\", oauth_signature_method=\"HMAC-SHA1\", oauth_version=\"1.0\", oauth_signature=\"MujZyJYT5ix2s388yF8sExvPIgA%3D\"
Signature:         MujZyJYT5ix2s388yF8sExvPIgA=
Escaped signature: MujZyJYT5ix2s388yF8sExvPIgA%3D
EXPECTED

  end




  private

  def run_command(arguments=[])
    s = StringIO.new
    command = arguments.shift
    OAuth::CLI.new(s, StringIO.new, StringIO.new, command, arguments).run

    s.rewind
    s.read
  end

  def parse(command)
    cli = OAuth::CLI.new(StringIO.new, StringIO.new, StringIO.new, command, [])
    cli.send(:parse_command, command)
  end

  def help_output
    <<-EXPECTED
Usage: oauth <command> [ARGS]
    -B, --body                       Use the request body for OAuth parameters.
        --consumer-key KEY           Specifies the consumer key to use.
        --consumer-secret SECRET     Specifies the consumer secret to use.
    -H, --header                     Use the 'Authorization' header for OAuth parameters (default).
    -Q, --query-string               Use the query string for OAuth parameters.
    -O, --options FILE               Read options from a file

  options for signing and querying
        --method METHOD              Specifies the method (e.g. GET) to use when signing.
        --nonce NONCE                Specifies the none to use.
        --parameters PARAMS          Specifies the parameters to use when signing.
        --signature-method METHOD    Specifies the signature method to use; defaults to HMAC-SHA1.
        --token TOKEN                Specifies the token to use.
        --secret SECRET              Specifies the token secret to use.
        --timestamp TIMESTAMP        Specifies the timestamp to use.
        --realm REALM                Specifies the realm to use.
        --uri URI                    Specifies the URI to use when signing.
        --version [VERSION]          Specifies the OAuth version to use.
        --no-version                 Omit oauth_version.
        --xmpp                       Generate XMPP stanzas.
    -v, --verbose                    Be verbose.

  options for authorization
        --access-token-url URL       Specifies the access token URL.
        --authorize-url URL          Specifies the authorization URL.
        --callback-url URL           Specifies a callback URL.
        --request-token-url URL      Specifies the request token URL.
        --scope SCOPE                Specifies the scope (Google-specific).
EXPECTED
  end
end
