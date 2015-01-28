require 'oauth/signature/base'

module OAuth::Signature::HMAC
  class RMD160 < OAuth::Signature::Base
    implements 'hmac-rmd160'
    digest_class OpenSSL::HMAC
    hash_class OpenSSL::Digest::RMD160
  end
end
