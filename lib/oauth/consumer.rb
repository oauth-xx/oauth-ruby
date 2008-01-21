require 'net/http'
require 'oauth/client/net_http'
module OAuth
  class Consumer
    
    @@default_options={
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
      #   :header - via the Authorize header (Default) ( option 1. in spec)
      #   :body - url form encoded in body of POST request ( option 2. in spec)
      #   :query_string - via the query part of the url ( option 3. in spec)
      :scheme=>:header, 
      
      # Default http method used for OAuth Token Requests (defaults to :post)
      :http_method=>:post, 
      
      :oauth_version=>"1.0"
    }
    
    attr_accessor :site,:options, :key, :secret,:http
    
    
    # Create a new consumer instance by passing it a configuration hash:
    #
    #   @consumer=OAuth::Consumer.new( key,secret,{
    #     :site=>"http://term.ie",
    #     :scheme=>:header,
    #     :http_method=>:post,
    #     :request_token_path=>"/oauth/example/request_token.php",
    #     :access_token_path=>"/oauth/example/access_token.php",
    #     :authorize_path=>"/oauth/example/authorize.php"
    #    })
    #
    # Start the process by requesting a token
    #
    #   @request_token=@consumer.get_request_token
    #   session[:request_token]=@request_token
    #   redirect_to @request_token.authorize_url
    #
    # When user returns create an access_token
    #
    #   @access_token=@request_token.get_access_token
    #   @photos=@access_token.get('/photos.xml')
    #
    #
    
    def initialize(consumer_key,consumer_secret,options={})
      # ensure that keys are symbols
      @options=@@default_options.merge( options.inject({}) do |options, (key, value)|
        options[key.to_sym] = value
        options
      end)
      @key = consumer_key
      @secret = consumer_secret
    end
    
    def http_method
      @http_method||=@options[:http_method]||:post
    end
    
    def http
      @http ||= Net::HTTP.new(uri.host, uri.port)
    end
    
    # will change
    def uri(url=nil)
      @uri||=URI.parse(url||site)
    end
    
    # Get a Request Token
    def get_request_token
      response=token_request(http_method,request_token_path)
      OAuth::RequestToken.new(self,response[:oauth_token],response[:oauth_token_secret])
    end
    
    # Creates, signs and performs an http request.
    # It's recommended to use the Token classes to set this up correctly.
    # The arguments parameters are a hash or string encoded set of parameters if it's a post request as well as optional http headers.
    # 
    #   @consumer.request(:get,'/people',@token,{:scheme=>:query_string})
    #   @consumer.request(:post,'/people',@token,{},@person.to_xml,{ 'Content-Type' => 'application/xml' })
    #
    def request(http_method,path, token=nil,request_options={},*arguments)
      http.request(create_signed_request(http_method,path,token,request_options,*arguments))
    end
    
    # Creates and signs an http request.
    # It's recommended to use the Token classes to set this up correctly
    def create_signed_request(http_method,path, token=nil,request_options={},*arguments)
      request=create_http_request(http_method,path,*arguments)
      sign!(request,token,request_options)
      request
    end
    
    # Creates a request and parses the result as url_encoded. This is used internally for the RequestToken and AccessToken requests.
    def token_request(http_method,path,token=nil,request_options={},*arguments)
      response=request(http_method,path,token,request_options,*arguments)
      if response.code=="200"
        CGI.parse(response.body).inject({}){|h,(k,v)| h[k.to_sym]=v.first;h}
      else 
        response.error! 
      end
    end

    # Sign the Request object. Use this if you have an externally generated http request object you want to sign.
    def sign!(request,token=nil, request_options = {})
      request.oauth!(http,self,token,{:scheme=>scheme}.merge(request_options))
    end
    
    # Return the signature_base_string
    def signature_base_string(request,token=nil, request_options = {})
      request.signature_base_string(http,self,token,{:scheme=>scheme}.merge(request_options))
    end

    def site
      @options[:site]
    end

    def scheme
      @options[:scheme]
    end
    
    def request_token_path
      @options[:request_token_path]
    end
    
    def authorize_path
      @options[:authorize_path]
    end
    
    def access_token_path
      @options[:access_token_path]
    end
    
    # TODO this is ugly, rewrite
    def request_token_url
      @options[:request_token_url]||site+request_token_path
    end

    def authorize_url
      @options[:authorize_url]||site+authorize_path
    end

    def access_token_url
      @options[:access_token_url]||site+access_token_path
    end

    protected
    
    # create the http request object for a given http_method and path
    def create_http_request(http_method,path,*arguments)
      http_method=http_method.to_sym
      if [:post,:put].include?(http_method)
        data=arguments.shift
      end
      headers=(arguments.first.is_a?(Hash) ? arguments.shift : {})
      case http_method
      when :post
        request=Net::HTTP::Post.new(path,headers)
      when :put
        request=Net::HTTP::Put.new(path,headers)
      when :get
        request=Net::HTTP::Get.new(path,headers)
      when :delete
        request=Net::HTTP::Delete.new(path,headers)
      when :head
        request=Net::HTTP::Head.new(path,headers)
      else
        raise ArgumentError, "Don't know how to handle http_method: :#{http_method.to_s}"
      end
      if data.is_a?(Hash)
        request.set_form_data(data)
      elsif data
        request.body=data.to_s
      end
      request
    end
    
    
  end
end
