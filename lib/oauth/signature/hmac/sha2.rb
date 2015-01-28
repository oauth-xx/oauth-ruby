require 'oauth/signature/base'

module OAuth::Signature::HMAC
  class SHA2 < OAuth::Signature::Base
    implements 'hmac-sha2'
    digest_class OpenSSL::HMAC
    hash_class OpenSSL::Digest::SHA2
  end
end
