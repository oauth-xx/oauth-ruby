require 'oauth/signature/hmac/base'

module OAuth::Signature::HMAC
  class RMD160 < Base
    require 'hmac-rmd160'
    
    implements 'hmac-rmd160'
    digest_klass 'RMD160'
  end
end
