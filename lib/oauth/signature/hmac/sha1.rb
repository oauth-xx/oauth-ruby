require 'oauth/signature/hmac/base'

module OAuth::Signature::HMAC
  class SHA1 < Base
    require 'hmac-sha1'
    
    implements 'hmac-sha1'
    digest_klass 'SHA1'
  end
end
