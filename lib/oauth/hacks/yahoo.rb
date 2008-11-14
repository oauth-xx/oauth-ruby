# Work-arounds for Yahoo!'s busted OAuth implementation
module OAuth
  module Client
    class Helper
      # Y! expects blank parameters to be omitted
      def oauth_parameters
        {
          'oauth_consumer_key'     => options[:consumer].key,
          'oauth_token'            => options[:token] ? options[:token].token : '',
          'oauth_signature_method' => options[:signature_method],
          'oauth_timestamp'        => timestamp,
          'oauth_nonce'            => nonce,
          'oauth_version'          => '1.0'
        }.reject { |k,v| v == "" }
      end

      # Y! doesn't accept a valid realm
      def header
        parameters = oauth_parameters
        parameters.merge!( { 'oauth_signature' => signature( options.merge({ :parameters => parameters }) ) } )
        header_params_str = parameters.map { |k,v| "#{k}=\"#{escape(v)}\"" }.join(', ')
        # return "OAuth realm=\"#{options[:realm]||''}\", #{header_params_str}"
        return "OAuth #{header_params_str}"
      end
    end
  end
end
