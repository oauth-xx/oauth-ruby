require 'oauth/signature/hmac/base'

module OAuth::Signature::HMAC
  class MD5 < Base
    require 'hmac-md5'
    implements 'hmac-md5'
    digest_klass 'MD5'
  end
end
