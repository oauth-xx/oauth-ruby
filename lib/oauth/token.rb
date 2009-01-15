require 'oauth/helper'
module OAuth
  
  # Superclass for the various tokens used by OAuth
  
  class Token
    include OAuth::Helper
    
    attr_accessor :token, :secret

    def initialize(token, secret)
      @token = token
      @secret = secret
    end
    
    def to_query
      "oauth_token=#{escape(token)}&oauth_secret=#{escape(secret)}"
    end
    
  end
  
  # Used on the server for generating tokens
  class ServerToken<Token
    
    def initialize
      super generate_key(16),generate_key
    end
  end
  # Superclass for tokens used by OAuth Clients
  class ConsumerToken<Token
    attr_accessor :consumer

    def initialize(consumer,token="",secret="")
      super token,secret
      @consumer=consumer
    end
    
    # Make a signed request using given http_method to the path
    #
    #   @token.request(:get,'/people')
    #   @token.request(:post,'/people',@person.to_xml,{ 'Content-Type' => 'application/xml' })
    #
    def request(http_method,path,*arguments)
      response=consumer.request(http_method,path,self,{},*arguments)
    end
    
    # Sign a request generated elsewhere using Net:HTTP::Post.new or friends
    def sign!(request,options = {})
      consumer.sign!(request,self,options)
    end
    
  end

  # The RequestToken is used for the initial Request.
  # This is normally created by the Consumer object.
  class RequestToken<ConsumerToken
    
    # Returns the authorization url that you need to use for redirecting the user
    def authorize_url
      consumer.authorize_url+"?oauth_token="+CGI.escape(token)
    end
    
    # exchange for AccessToken on server
    def get_access_token(options={})
      response=consumer.token_request(consumer.http_method,consumer.access_token_url,self,options)
      OAuth::AccessToken.new(consumer,response[:oauth_token],response[:oauth_token_secret])
    end
  end
  
  # The Access Token is used for the actual "real" web service calls thatyou perform against the server
  class AccessToken<ConsumerToken

    # The less intrusive way. Otherwise, if we are to do it correctly inside consumer,
    # we need to restructure and touch more methods: request(), sign!(), etc.
    def request(http_method, path, *arguments)
      request_uri = URI.parse(path)
      site_uri = consumer.uri
      is_service_uri_different = (request_uri.absolute? && request_uri != site_uri)
      consumer.uri(request_uri) if is_service_uri_different
      resp = super(http_method, path, *arguments)
      # NOTE: reset for wholesomeness? meaning that we admit only AccessToken service calls may use different URIs?
      # so reset in case consumer is still used for other token-management tasks subsequently?
      consumer.uri(site_uri) if is_service_uri_different
      resp
    end
    
    # Make a regular get request using AccessToken
    #
    #   @response=@token.get('/people')
    #   @response=@token.get('/people',{'Accept'=>'application/xml'})
    #
    def get(path,headers={})
      request(:get,path,headers)
    end
    
    # Make a regular head request using AccessToken
    #
    #   @response=@token.head('/people')
    #
    def head(path,headers={})
      request(:head,path,headers)
    end

    # Make a regular post request using AccessToken
    #
    #   @response=@token.post('/people')
    #   @response=@token.post('/people',{:name=>'Bob',:email=>'bob@mailinator.com'})
    #   @response=@token.post('/people',{:name=>'Bob',:email=>'bob@mailinator.com'},{'Accept'=>'application/xml'})
    #   @response=@token.post('/people',nil,{'Accept'=>'application/xml'})
    #   @response=@token.post('/people',@person.to_xml,{'Accept'=>'application/xml','Content-Type' => 'application/xml'})
    #
    def post(path, body = '',headers={})
      request(:post,path,body,headers)
    end

    # Make a regular put request using AccessToken
    #
    #   @response=@token.put('/people/123')
    #   @response=@token.put('/people/123',{:name=>'Bob',:email=>'bob@mailinator.com'})
    #   @response=@token.put('/people/123',{:name=>'Bob',:email=>'bob@mailinator.com'},{'Accept'=>'application/xml'})
    #   @response=@token.put('/people/123',nil,{'Accept'=>'application/xml'})
    #   @response=@token.put('/people/123',@person.to_xml,{'Accept'=>'application/xml','Content-Type' => 'application/xml'})
    #
    def put(path, body = '', headers={})
      request(:put,path,body,headers)
    end
    
    # Make a regular delete request using AccessToken
    #
    #   @response=@token.delete('/people/123')
    #   @response=@token.delete('/people/123',{'Accept'=>'application/xml'})
    #
    def delete(path,headers={})
      request(:delete,path,headers)
    end
  end
end
