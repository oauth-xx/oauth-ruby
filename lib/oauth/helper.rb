require 'openssl'
require 'base64'
require 'cgi'
module OAuth
  module Helper
    extend self

    def escape(value)
      CGI.escape(value.to_s).gsub("%7E", '~').gsub("+", "%20")
    end
    
    def generate_key(size=32)
      Base64.encode64(OpenSSL::Random.random_bytes(size)).gsub(/\W/,'')
    end    
    
  end
end