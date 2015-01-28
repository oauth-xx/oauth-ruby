require 'oauth/signature/base'

module OAuth::Signature::HMAC
  class MD5 < OAuth::Signature::Base
    implements 'hmac-md5'
    digest_class OpenSSL::HMAC
    hash_class OpenSSL::Digest::MD5
  end
end
