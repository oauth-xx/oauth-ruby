require 'oauth/signature/base'
require 'openssl'

module OAuth::Signature::RSA
  class SHA1 < OAuth::Signature::Base
    implements 'rsa-sha1'

    def ==(cmp_signature)
      public_key = OpenSSL::PKey::RSA.new(request.consumer.secret)
      public_key.verify(OpenSSL::Digest::SHA1.new, cmp_signature, signature_base_string)
    end

    private

    def digest
      private_key = OpenSSL::PKey::RSA.new(request.consumer.secret)
      private_key.sign(OpenSSL::Digest::SHA1.new, signature_base_string)
    end
  end
end
