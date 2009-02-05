require 'optparse'
require 'oauth'

module OAuth
  class CLI
    SUPPORTED_COMMANDS = %w(sign)

    attr_reader :command
    attr_reader :options
    attr_reader :stdout

    def self.execute(stdout, arguments = [])
      self.new.execute(stdout, arguments)
    end

    def initialize
      @options = {}
    end

    def execute(stdout, arguments = [])
      @stdout = stdout
      extract_command_and_parse_options(arguments)

      if sufficient_options? && valid_command?
        case command
        when "sign"
          parameters = prepare_parameters

          request = OAuth::RequestProxy.proxy \
             "method"     => options[:method],
             "uri"        => options[:uri],
             "parameters" => parameters

          if verbose?
            stdout.puts "OAuth parameters:"
            request.oauth_parameters.each do |k,v|
              stdout.puts "  " + [k, v] * ": "
            end
            stdout.puts
          end

          request.sign! \
            :consumer_secret => options[:oauth_consumer_secret],
            :token_secret    => options[:oauth_token_secret]

          if verbose?
            stdout.puts "Method: #{request.method}"
            stdout.puts "Base URI: #{request.uri}"
            stdout.puts "Normalized params: #{request.normalized_parameters}"
            stdout.puts "Signature base string: #{request.signature_base_string}"
            stdout.puts "Request URI: #{request.signed_uri}"
            stdout.puts "Normalized URI: #{request.normalized_uri}"
            stdout.puts "Authorization header: #{request.oauth_header(:realm => options[:realm])}"
            stdout.puts "Signature:         #{request.signature}"
            stdout.puts "Escaped signature: #{OAuth::Helper.escape(request.signature)}"
          else
            stdout.puts signature
          end
        end
      else
        usage
      end
    end

  protected

    def extract_command_and_parse_options(arguments)
      @command = arguments[-1]
      parse_options(arguments[0..-1])
    end

    def option_parser
      option_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] <command>"

        # defaults
        options[:oauth_nonce] = OAuth::Helper.generate_key
        options[:oauth_signature_method] = "HMAC-SHA1"
        options[:oauth_timestamp] = OAuth::Helper.generate_timestamp
        options[:oauth_version] = "1.0"
        options[:params] = ""

        opts.on("--consumer-key KEY", "Specifies the consumer key to use.") do |v|
          options[:oauth_consumer_key] = v
        end

        opts.on("--consumer-secret SECRET", "Specifies the consumer secret to use.") do |v|
          options[:oauth_consumer_secret] = v
        end

        opts.on("--method METHOD", "Specifies the method (e.g. GET) to use when signing.") do |v|
          options[:method] = v
        end

        opts.on("--nonce NONCE", "Specifies the none to use.") do |v|
          options[:oauth_nonce] = v
        end

        opts.on("--parameters PARAMS", "Specifies the parameters to use when signing.") do |v|
          options[:params] = v
        end

        opts.on("--signature-method METHOD", "Specifies the signature method to use; defaults to HMAC-SHA1.") do |v|
          options[:oauth_signature_method] = v
        end

        opts.on("--secret SECRET", "Specifies the token secret to use.") do |v|
          options[:oauth_token_secret] = v
        end

        opts.on("--timestamp TIMESTAMP", "Specifies the timestamp to use.") do |v|
          options[:oauth_timestamp] = v
        end

        opts.on("--token TOKEN", "Specifies the token to use.") do |v|
          options[:oauth_token] = v
        end

        opts.on("--realm REALM", "Specifies the realm to use.") do |v|
          options[:realm] = v
        end

        opts.on("--uri URI", "Specifies the URI to use when signing.") do |v|
          options[:uri] = v
        end

        opts.on("--version VERSION", "Specifies the OAuth version to use.") do |v|
          options[:oauth_version] = v
        end

        opts.on("--no-version", "Omit oauth_version.") do
          options[:oauth_version] = nil
        end

        opts.on("-v", "--verbose", "Be verbose.") do
          options[:verbose] = true
        end
      end
    end

    def parse_options(arguments)
      option_parser.parse!(arguments)
    end

    def prepare_parameters
      {
        "oauth_consumer_key"     => options[:oauth_consumer_key],
        "oauth_nonce"            => options[:oauth_nonce],
        "oauth_timestamp"        => options[:oauth_timestamp],
        "oauth_token"            => options[:oauth_token],
        "oauth_signature_method" => options[:oauth_signature_method],
        "oauth_version"          => options[:oauth_version]
      }.reject { |k,v| v.nil? || v == "" }.merge(CGI.parse(options[:params]))
    end

    def sufficient_options?
      options[:oauth_consumer_key] && options[:oauth_consumer_secret] && options[:method] && options[:uri]
    end

    def usage
      stdout.puts option_parser.help
      stdout.puts
      stdout.puts "Available commands:"
      SUPPORTED_COMMANDS.each do |command|
        puts "   #{command.ljust(15)}"
      end
    end

    def valid_command?
      SUPPORTED_COMMANDS.include?(command)
    end

    def verbose?
      options[:verbose]
    end
  end
end
