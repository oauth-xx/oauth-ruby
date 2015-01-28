require 'oauth/signature/base'

module OAuth::Signature::HMAC
  class SHA1 < OAuth::Signature::Base
    implements 'hmac-sha1'
    digest_class OpenSSL::HMAC
    hash_class OpenSSL::Digest::SHA1
  end
end
