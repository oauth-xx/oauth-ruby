module OAuth
  class Consumer<ConsumerCredentials
    
    @@default_params={
      # Signature method used by server. Defaults to HMAC-SHA1
      :oauth_signature_method=>'HMAC-SHA1',
      
      # default paths on site. These are the same as the defaults set up by the generators
      :request_token_path=>'/oauth/request_token',
      :authorize_path=>'/oauth/authorize',
      :access_token_path=>'/oauth/access_token',
      
      # How do we send the oauth values to the server see 
      # http://oauth.googlecode.com/svn/spec/branches/1.0/drafts/6/spec.html#consumer_req_param for more info
      #
      # Possible values:
      #
      #   :authorize - via the Authorize header (Default) ( option 1. in spec)
      #   :post - url form encoded in body of POST request ( option 2. in spec)
      #   :query - via the query part of the url ( option 3. in spec)
      :auth_method=>:authorize, 
      
      # Default http method used for OAuth Token Requests (defaults to :post)
      :http_method=>:post, 
      
      :oauth_version=>"1.0"
    }
    
    attr_accessor :site,:params
    
    # Create a new consumer instance by passing it a configuration hash:
    #
    #   @consumer=OAuth::Consumer.new( {
    #     :consumer_key=>"key",
    #     :consumer_secret=>"secret",
    #     :site=>"http://term.ie",
    #     :auth_method=>:authorize,
    #     :http_method=>:post,
    #     :request_token_path=>"/oauth/example/request_token.php",
    #     :access_token_path=>"/oauth/example/access_token.php",
    #     :authorize_path=>"/oauth/example/authorize.php"
    #    })
    #
    # Start the process by requesting a token
    #
    #   @request_token=@consumer.request_token
    #   session[:request_token]=@request_token
    #   redirect_to @request_token.authorize_url
    #
    # When user returns create an access_token
    #
    #   @access_token=@request_token.access_token
    #   @photos=@access_token.get('http://test.com/photos.xml')
    #
    #
    
    def initialize(params)
      # ensure that keys are symbols
      @params=@@default_params.merge( params.inject({}) do |options, (key, value)|
        options[key.to_sym] = value
        options
      end)
      super @params[:consumer_key],@params[:consumer_secret]
      @site=@params[:site]
      raise ArgumentError, 'Missing site URI' unless @site
    end
    
    def http_method
      @http_method||=@params[:http_method]||:post
    end
    
    # Get a Request Token
    def get_request_token
      request=create_request(http_method,request_token_path)
      response=request.perform_token_request(self.secret)
      OAuth::RequestToken.new(self,response[:oauth_token],response[:oauth_token_secret])
    end
    
    def create_request(http_method,path, oauth_params={},*arguments)
      OAuth::Request.new(http_method,site,path,oauth_params.merge({
        :oauth_consumer_key=>self.key,
        :realm=>authorize_url,
        :oauth_signature_method=>params[:oauth_signature_method],
        :oauth_version=>params[:oauth_version],
        :auth_method=>auth_method
        }),*arguments)
    end

    def signed_request(http_method, path, oauth_params={},token_secret=nil,*arguments)
      request=create_request(http_method,path,oauth_params,*arguments)
      request.sign(self.secret,token_secret)
      request
    end
    
    def auth_method
      @params[:auth_method]
    end
    
    def request_token_path
      @params[:request_token_path]
    end
    
    def authorize_path
      @params[:authorize_path]
    end
    
    def access_token_path
      @params[:access_token_path]
    end

    def request_token_url
      site+request_token_path
    end

    def authorize_url
      site+authorize_path
    end

    def access_token_url
      site+access_token_path
    end
  end
end
