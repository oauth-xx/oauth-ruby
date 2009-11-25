require 'oauth/signature/hmac/base'

module OAuth::Signature::HMAC
  class SHA2 < Base
    require 'hmac-sha2'
    implements 'hmac-sha2'
    digest_klass 'SHA2'
  end
end
