module OAuth
  class ConsumerCredentials
    attr_accessor :key, :secret

    def initialize(key, secret)
      @key = key
      @secret = secret
      raise ArgumentError, 'Missing consumer credentials ("key and/or secret")' unless @key && @secret
    end
  end
  
end
