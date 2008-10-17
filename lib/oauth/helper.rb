require 'openssl'
require 'base64'

module OAuth
  module Helper
    extend self

    def escape(value)
      URI::escape(value.to_s, OAuth::RESERVED_CHARACTERS)
    end

    def generate_key(size=32)
      Base64.encode64(OpenSSL::Random.random_bytes(size)).gsub(/\W/, '')
    end

    alias_method :generate_nonce, :generate_key

    def generate_timestamp
      Time.now.to_i.to_s
    end

    def normalize(params)
      params.sort.map do |k, values|

        if values.is_a?(Array)
          # multiple values were provided for a single key
          values.sort.collect do |v|
            [escape(k),escape(v)] * "="
          end
        else
          [escape(k),escape(values)] * "="
        end
      end * "&"
    end

    def unescape(value)
      URI.unescape(value.gsub('+', '%2B'))
    end
  end
end