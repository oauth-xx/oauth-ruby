require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'action_controller/test_process'
require 'oauth'
class RequestTest < Test::Unit::TestCase
  include OAuth::Key
  include OAuth::OAuthTestHelper
  
  def setup
    @request=OAuth::Request.new( :get,"http://test.COM:80","/oauth?stuff=1&picture=test.png", {:realm=>'http://test.com/oauth/authorize',:oauth_field1=>"test",:oauth_field2=>"hello",'string_key'=>"should be set"})
  end
  
  def test_accessors
    #as symbols
    assert_equal @request[:oauth_field1],"test"
    assert_equal @request[:oauth_field2],"hello"
    assert_equal @request[:string_key],"should be set"    
    assert_equal @request[:oauth_signature_method],"HMAC-SHA1"    
    #as strings
    assert_equal @request['oauth_field1'],"test"
    assert_equal @request['oauth_field2'],"hello"
    assert_equal @request['string_key'],"should be set"    
  end
  
  def test_to_query
    assert_equal "oauth_field1=test&oauth_field2=hello&oauth_nonce=#{URI.escape(@request.nonce)}&oauth_signature_method=HMAC-SHA1&oauth_timestamp=#{@request.timestamp}&oauth_version=1.0&picture=test.png&string_key=should%20be%20set&stuff=1",@request.to_query
  end

  def test_to_auth_string
    assert_equal "OAuth realm=\"http://test.com/oauth/authorize\", oauth_field1=\"test\", oauth_field2=\"hello\", oauth_nonce=\"#{URI.escape(@request.nonce)}\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"#{@request.timestamp}\", oauth_version=\"1.0\", string_key=\"should%20be%20set\"",@request.to_auth_string
  end
  
  def test_has_http_method
    assert_equal "GET",@request.http_method
  end
  
  def test_has_realm
    assert_equal 'http://test.com/oauth/authorize',@request.realm
  end
  
  def test_removed_realm_from_params
    assert_nil @request[:realm]
  end

  def test_url_normalization
    #should remove port 80 from http
    assert_equal "http://test.com:80/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "http://test.com/oauth",@request.normalized_url

    # should not have port
    @request.site="http://test.com"
    assert_equal "http://test.com/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "http://test.com/oauth",@request.normalized_url
    
    #should remove port 443 from https
    @request.site="https://test.com:443"
    assert_equal "https://test.com:443/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "https://test.com/oauth",@request.normalized_url
    
    #should retain port number
    @request.site="https://test.com:11822"
    assert_equal "https://test.com:11822/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "https://test.com:11822/oauth",@request.normalized_url
    
    # should retain port 80 on https
    @request.site="https://test.com:80"
    assert_equal "https://test.com:80/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "https://test.com:80/oauth",@request.normalized_url

    # should retain port 443 on http
    @request.site="http://test.com:443"
    assert_equal "http://test.com:443/oauth?stuff=1&picture=test.png",@request.url
    assert_equal "http://test.com:443/oauth",@request.normalized_url
    
  end

  def test_auth_methods_on_various_http_methods
    # defaults
    assert_equal :authorize,create_request(:get).auth_method
    assert_equal :authorize,create_request(:head).auth_method
    assert_equal :authorize,create_request(:delete).auth_method
    assert_equal :authorize,create_request(:post).auth_method
    assert_equal :authorize,create_request(:put).auth_method
    
    # authorize
    assert_equal :authorize,create_request(:get,{:auth_method=>:authorize}).auth_method
    assert_equal :authorize,create_request(:head,{:auth_method=>:authorize}).auth_method
    assert_equal :authorize,create_request(:delete,{:auth_method=>:authorize}).auth_method
    assert_equal :authorize,create_request(:post,{:auth_method=>:authorize}).auth_method
    assert_equal :authorize,create_request(:put,{:auth_method=>:authorize}).auth_method
    
    # query
    assert_equal :query,create_request(:get,{:auth_method=>:query}).auth_method
    assert_equal :query,create_request(:head,{:auth_method=>:query}).auth_method
    assert_equal :query,create_request(:delete,{:auth_method=>:query}).auth_method
    assert_equal :authorize,create_request(:post,{:auth_method=>:query}).auth_method
    assert_equal :authorize,create_request(:put,{:auth_method=>:query}).auth_method

    # post
    assert_equal :authorize,create_request(:get,{:auth_method=>:post}).auth_method
    assert_equal :authorize,create_request(:head,{:auth_method=>:post}).auth_method
    assert_equal :authorize,create_request(:delete,{:auth_method=>:post}).auth_method
    assert_equal :post,create_request(:post,{:auth_method=>:post}).auth_method
    assert_equal :post,create_request(:put,{:auth_method=>:post}).auth_method
  end

  def create_request(http_method,params={},*arguments)
    OAuth::Request.new( http_method,'http://photos.example.net','/test',{
      :oauth_consumer_key=>"dpf43f3p2l4k3l03"
    }.merge(params),*arguments)
  end
  
  def test_has_body
    request=create_request(:post,{},"BODY")
    assert_equal "BODY",request.body
    
  end
  def test_has_nonce
    assert_not_nil @request.nonce
  end

  def test_has_timestamp
    assert_not_nil @request.timestamp
  end
  
  def test_not_signed
    assert !@request.signed?
  end

  def test_has_signature_method
    assert_equal @request.signature_method,"HMAC-SHA1"  
  end
  
  def test_not_signed
    assert !@request.signed?
  end

  def test_not_verified
    assert !@request.verify?("secret")    
  end

  def test_sign_request_token_with_query_string
    @consumer_secret="kd94hf93k423kf44"
    @test_params={
      :oauth_consumer_key=>"dpf43f3p2l4k3l03"
    }
    
    @request=OAuth::Request.new( :get,'http://photos.example.net','/photos?file=vacation.jpg&size=original', @test_params)
    assert !@request.signed?
    assert !@request.verify?(@consumer_secret)
    @request.sign(@consumer_secret)    
    assert @request.signed?
    assert @request.verify?(@consumer_secret)    
    orig_sig=@request.signature
    
    @incoming=mock_incoming_request_with_query(@request)
    assert_equal "photos.example.net",@incoming.host_with_port
    assert_equal "/photos",@incoming.path
    assert_equal :get,@incoming.method
    assert_equal( {"file"=>"vacation.jpg",
      "size"=>"original",
      "oauth_consumer_key"=>"dpf43f3p2l4k3l03",
      'oauth_timestamp'=>@request[:oauth_timestamp],
      "oauth_nonce"=>@request[:oauth_nonce],
      "oauth_signature_method"=>'HMAC-SHA1',
      "oauth_version"=>"1.0",
      "oauth_signature"=>orig_sig
      },@incoming.parameters)
      
      
    assert_equal "dpf43f3p2l4k3l03",OAuth::Request.extract_consumer_key(@incoming)
    
    @request=OAuth::Request.incoming(@incoming)
    assert @request.signed?
    assert_equal( {
      :file=>"vacation.jpg",
      :size=>"original",
      :oauth_consumer_key=>"dpf43f3p2l4k3l03",
      :oauth_timestamp=>@request[:oauth_timestamp],
      :oauth_nonce=>@request[:oauth_nonce],
      :oauth_signature_method=>'HMAC-SHA1',
      :oauth_version=>"1.0",
      :oauth_signature=>orig_sig
      },@request.to_hash)
    assert @request.verify?(@consumer_secret)
    assert_equal orig_sig,@request.signature
  end

  def test_sign_request_token_with_authorize_header
    @consumer_secret="kd94hf93k423kf44"
    @test_params={
      :oauth_consumer_key=>"dpf43f3p2l4k3l03",
      :realm=>"http://photos.example.net/oauth/authorize"
    }
    
    @request=OAuth::Request.new( :get,'http://photos.example.net','/photos?file=vacation.jpg&size=original', @test_params)
    assert !@request.signed?
    assert !@request.verify?(@consumer_secret)
    
    @request.sign(@consumer_secret)    
    assert @request.signed?
    assert @request.verify?(@consumer_secret)    
    assert_equal '/photos?file=vacation.jpg&size=original',@request.path
    orig_sig=@request.signature
    orig_base=OAuth::Signature.create(@request,@consumer_secret).base_string
    
    orig_query_params=@request.http_parameters
    
    @incoming=mock_incoming_request_with_authorize_header(@request)
    assert_equal "photos.example.net",@incoming.host_with_port
    assert_equal "/photos",@incoming.path
    assert_equal :get,@incoming.method
    assert_equal @request.to_auth_string, @incoming.env['HTTP_AUTHORIZATION']
    assert_equal "dpf43f3p2l4k3l03",OAuth::Request.extract_consumer_key(@incoming)
    

    
    @request=OAuth::Request.incoming(@incoming)
    assert_equal '/photos?file=vacation.jpg&size=original',@request.path
    
    assert_equal orig_query_params,@request.http_parameters
    
    # test base string
    new_base=OAuth::Signature.create(@request,@consumer_secret).base_string
    assert_equal orig_base,new_base
    
    assert_equal 'GET',@request.http_method
    assert_equal "http://photos.example.net/photos?file=vacation.jpg&size=original",@request.url
    assert @request.signed?

    assert_equal( {
      :file=>"vacation.jpg",
      :size=>"original",
      :oauth_consumer_key=>"dpf43f3p2l4k3l03",
      :oauth_timestamp=>@request[:oauth_timestamp],
      :oauth_nonce=>@request[:oauth_nonce],
      :oauth_signature_method=>'HMAC-SHA1',
      :oauth_version=>"1.0",
      :oauth_signature=>orig_sig
      },@request.to_hash)

    assert @request.verify?(@consumer_secret)
    assert_equal orig_sig,@request.signature
  end
    
  def test_sign_access_token
    @consumer_secret="kd94hf93k423kf44"
    @token_secret="pfkkdhi9sl3r4s00"
    @test_params={
      :oauth_consumer_key=>"dpf43f3p2l4k3l03",
      :oauth_token=>"nnch734d00sl2jdk"
    }
    
    @request=OAuth::Request.new( :get,'http://photos.example.net','/photos?file=vacation.jpg&size=original', @test_params)
    assert !@request.signed?
    assert !@request.verify?(@consumer_secret,@token_secret)    
    @request.sign(@consumer_secret,@token_secret)    
    assert @request.signed?
    assert @request.verify?(@consumer_secret,@token_secret)    
  end

  def test_sign_post_request_url_form_encoded
    @consumer_secret="kd94hf93k423kf44"
    @token_secret="pfkkdhi9sl3r4s00"
    @test_params={
      :oauth_consumer_key=>"dpf43f3p2l4k3l03",
      :oauth_token=>"nnch734d00sl2jdk"
    }
    
    @request=OAuth::Request.new( :post,'http://photos.example.net','/photos', @test_params,"file=vacation.jpg&size=original")
    assert_equal "application/x-www-form-urlencoded",@request.content_type
    assert !@request.signed?
    assert !@request.verify?(@consumer_secret,@token_secret)
    @request.sign(@consumer_secret,@token_secret)    
    assert @request.signed?
    assert @request.verify?(@consumer_secret,@token_secret)
    assert_equal "file=vacation.jpg&size=original",@request.body
  end

  
end
