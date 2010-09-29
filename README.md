# Ruby OAuth 

Is a RubyGem for implementing both OAuth clients and servers in Ruby applications.

## Basics

This library is intended to be used in creating Ruby Consumer and Service Provider applications. 

It can be used in any Ruby application.  This includes applications written using a framework like [Rails](http://github.com/rails/rails) or [Sinatra](http://github.com/sinatra/sinatra).

It originated from the [OAuth Rails Plugin](http://code.google.com/p/oauth-plugin/) which now requires this gem.

The official source code repository is [here](http://github.com/oauth/oauth-ruby).

## Installation

  [sudo] gem install oauth

## Usage

* Require the library
* Create a consumer
* Get a request token
* Get an access token
* Make API calls

## Example

In your application or script (e.g. "awesome_client.rb")

    # Require the library
    require 'rubygems'
    require 'oauth'
    
    # Create a new consumer instance by passing it a configuration hash:
    @consumer = OAuth::Consumer.new("key","secret", :site => "https://agree2")

    # Start the process by getting a request token
    @request_token = @consumer.get_request_token
    session[:request_token] = @request_token
    redirect_to @request_token.authorize_url
    
    # When the user returns, create an access_token
    @access_token = @request_token.get_access_token
    @photos = @access_token.get('/photos.xml')

Now that you have an access token, you can use Typhoeus to interact with the OAuth provider if you choose.

    oauth_params = {:consumer => oauth_consumer, :token => access_token}
    hydra = Typhoeus::Hydra.new
    req = Typhoeus::Request.new(uri, options) 
    oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => uri))
    req.headers.merge!({"Authorization" => oauth_helper.header}) # Signs the request
    hydra.queue(req)
    hydra.run
    @response = req.response

Be sure to check out the examples in

    examples/yql.rb

## More Information

* [Mailing List, Google Group](http://groups.google.com/group/oauth-ruby)
* [API Documentation (RDoc)](http://rdoc.info/projects/oauth/oauth-ruby/)
* [OAuth Specification](http://oauth.net/core/1.0/)

## Developers (Submitting Patches)

To submit a patch, please fork the [oauth project](http://github.com/oauth/oauth-ruby) and create a patch with tests. Once you're happy with it send a pull request and post a message to the google group.

## License

This code is free to use under the terms of the [MIT license](http://www.opensource.org/licenses/mit-license.html). 

## Contact

OAuth Ruby has been created and maintained by a large number of talented individuals. 
The current maintainer is Aaron Quint ([quirkey](http://github.com/quirkey)).

Comments are welcome. Send an email to the [OAuth Ruby Mailing List](http://groups.google.com/group/oauth-ruby).
