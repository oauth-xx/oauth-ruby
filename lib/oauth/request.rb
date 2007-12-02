require 'uri'
require 'cgi'
require 'open-uri'
require 'net/http' 
module OAuth
  # This encapsulates all the request details for OAuth.
  #
  # On the consumer side you shouldn't use this directly but rather Use consumer.get_request_token for the initial token
  # and access token for actual web service calls
  #
  # On the service provider side there are various interesting methods.
  #
  # To find the consumer_key for a request in a rails app do:
  # 
  #   @consumer_key=OAuth::Request.extract_consumer_key(request)
  #
  # To extract an OAuth::Request for a rails request in a rails app do:
  #
  #   @oauth_request=OAuth::Request.incoming(request)
  #   @token=AccessToken.find_by_token @oauth_request.token
  #   return @oauth_request.verify?(@token.client_application.secret,@token.secret)
  #
  # This example assumes an ActiveRecord Model called AccessToken with a token and a secret column.
  # This is associated with a ActiveRecord Model ClientApplication (the consumer), which has a key and secret column.
  #
  class Request
    include OAuth::Key
    
    attr_accessor :oauth_params,:headers,:site,:path,:realm,:body,:auth_method
    
    @@default_oauth_params={:oauth_signature_method=>'HMAC-SHA1',:oauth_version=>"1.0",:realm=>''}
    
    def initialize(http_method,site,path,oauth_params={},*arguments)
      # ensure that keys are symbols
      @oauth_params=@@default_oauth_params.merge( oauth_params.inject({}) do |options, (key, value)|
        options[key.to_sym] = value
        options
      end)
      self.http_method=http_method
      self.site=site
      self.path=path
      self.realm=@oauth_params.delete(:realm)
      self.auth_method=@oauth_params.delete(:auth_method)||:authorize
      self.body=arguments.shift if ['POST','PUT'].include?(self.http_method)
      self.headers=arguments.shift||{}
      self.headers['Content-Type']||='application/x-www-form-urlencoded' if ['POST','PUT'].include?(self.http_method)

      self[:oauth_timestamp]=create_timestamp unless self.timestamp
      self[:oauth_nonce]=generate_key(24) unless self.nonce
      
      # Default to Authorize header if http method doesn't support the specified auth_method
      if ['GET','HEAD','DELETE'].include?(self.http_method)
        self.auth_method=:authorize unless self.auth_method==:query
      else
        self.auth_method=:authorize unless self.auth_method==:post
      end

    end
    
    # Use to extract the consumer key from a http request object
    # This is intended for use on the server
    def self.extract_consumer_key(http_request)
      auth=http_request.env["HTTP_AUTHORIZATION"]
      if auth && auth[0..5]=="OAuth "&&auth=~/ oauth_consumer_key="([^, ]+)"/
        $1
      else
        http_request.parameters[:oauth_consumer_key]
      end
    end
    
    # This takes a rails like Request and returns an OAuth request object
    def self.incoming(http_request)
      auth=http_request.env["HTTP_AUTHORIZATION"]
      if auth && auth[0..5]=="OAuth "
        parameters=auth[5,auth.size].scan(/ ([^= ]+)="([^"]*)",?/).inject({}) do |h,(k,v)| 
          h[k.to_sym]=CGI.unescape(v)
          h
        end
        _path=http_request.request_uri
      else
        parameters=http_request.query_parameters#.reject{|k,v| ['controller','action'].include?(k)}
#        non_oauth=to_name_value_pair_array(http_request.query_parameters.reject(){|k,v| k.to_s=~/oauth_/}).join(/&/)
        _path=http_request.request_uri
#        _path=http_request.path+'?'+non_auth
      end
      return false unless  parameters[:oauth_consumer_key]&&parameters[:oauth_nonce]&&parameters[:oauth_timestamp]&&parameters[:oauth_signature_method]&&parameters[:oauth_signature]&&parameters[:oauth_version]
      if http_request.post?||http_request.put?
        Request.new(http_request.method,"http://#{http_request.host_with_port}",_path,parameters,http_request.raw_post,{'Content-Type'=>http_request.content_type})
      else
        Request.new(http_request.method,"http://#{http_request.host_with_port}",_path,parameters)
      end
    end
        
    def perform(consumer_secret,token_secret=nil)
      http_klass=(uri.scheme=="https" ? Net::HTTPS : Net::HTTP)
      http_klass.start(uri.host,uri.port) do |http|
        sign(consumer_secret,token_secret)
        
        case auth_method
        when :query
          _path="#{uri.path}?#{to_query}"
        when :post
          self.body=to_query
        else
          headers['Authorization']=to_auth_string
        end
        _path||=path
        # TODO if realm is set use auth header
        if (['POST','PUT'].include?(http_method))
#          headers['Content-Length']=body.size.to_s unless body.nil?          
          http.send(http_method.downcase.to_sym,_path,body,headers)
        else # any request without a body
          http.send(http_method.downcase.to_sym,_path,headers)
        end
      end
    end
    
    def perform_token_request(consumer_secret,token_secret=nil)
      response=perform(consumer_secret,token_secret)
      if response.code=="200"
        CGI.parse(response.body).inject({}){|h,(k,v)| h[k.to_sym]=v.first;h}
      else 
        response.error! 
      end 
    end
    
    def http_method=(value)
      @http_method=value.to_s.strip.upcase
    end
    
    def http_method
      @http_method
    end
    
    def content_type
      @content_type||=headers['Content-Type']
    end
    
    def site=(_site)
      @site=_site.downcase
      @uri=nil # invalidate uri
      @site
    end
    
    def path=(_path)
      @path=_path
      @uri=nil # invalidate uri
      @path
    end

    def uri
      @uri||=URI.parse(url)
    end
    
    def url
      (site+path)
    end
    
    # produces a hash of the query or post parameters depending on http method
    def http_parameters
      @http_params||=parse_url_form_encoded( body||uri.query||'') 
    end
    
    def parse_url_form_encoded(string)
      CGI.parse(string).inject({}){|h,(k,v)| h[k.to_sym]=v[0];h}
    end
    
    def normalized_url
      uri=URI.split(url)
      if uri[3].nil?||(uri[3]=='80'&&uri[0]=='http')||(uri[3]=='443'&&uri[0]=='https')
        port=""
      else
        port=":#{uri[3]}"
      end
      "#{uri[0]}://#{uri[2]}#{port}#{uri[5]}"
    end
    
    def [](key)
      oauth_params[key.to_sym]
    end
    
    def []=(key,value)
      oauth_params[key.to_sym]=value
    end
    
    def timestamp
      self[:oauth_timestamp]
    end
    
    def create_timestamp
      Time.now.utc.to_i.to_s
    end
    
    def nonce
      self[:oauth_nonce]
    end

    def token
      self[:oauth_token]
    end
    
    def to_name_value_pair_array(hash,with={})
      hash.merge(with).collect{|(key,value)| "#{escape(key.to_s)}=#{escape(value)}"}.sort
    end

    def to_hash(with={})
      oauth_params.merge(http_parameters).merge(with)
    end
    
    def to_query(with={})
      (to_name_value_pair_array(to_hash(with))).sort.join("&")
    end

    def to_query_without_signature(with={})
      (to_name_value_pair_array(oauth_params_without_signature,with)).sort.join("&")
    end

    def to_auth_string
      "OAuth realm=\"#{realm}\", "+oauth_params.collect{|(key,value)| "#{escape(key.to_s)}=\"#{escape(value)}\""}.sort.join(", ")
    end
    
    def to_base_string(secret)
      to_query({:oauth_secret=>secret})
    end

    def oauth_params_without_signature
      to_hash.reject{|key,value| key.to_sym==:oauth_signature}
    end
    
    def signature
      self[:oauth_signature]
    end

    def signature=(_signature)
      self[:oauth_signature]=_signature
    end
    
    def signature_method
      self[:oauth_signature_method]
    end
        
    def signature_method=(_signature_method)
      self[:oauth_signature_method]=_signature_method
    end

    def signed?
      signature!=nil
    end
    
    def sign(consumer_secret,token_secret=nil)
      OAuth::Signature.create(self,consumer_secret,token_secret).sign!
    end
    
    def verify?(consumer_secret,token_secret=nil)
      OAuth::Signature.create(self,consumer_secret,token_secret).verify?
    end
    
  end
end
