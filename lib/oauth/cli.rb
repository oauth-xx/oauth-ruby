require 'optparse'
require 'oauth/cli/base_command'
require 'oauth/cli/help_command'
require 'oauth/cli/query_command'
require 'oauth/cli/authorize_command'
require 'oauth/cli/sign_command'
require 'oauth/cli/version_command'

module OAuth
  class CLI
    ALIASES = {
      'h' => 'help',
      'v' => 'version',
      'q' => 'query',
      'a' => 'authorize',
      's' => 'sign',
    }

    def initialize(stdout, stdin, stderr, command, arguments)
      klass = get_command_class(parse_command(command))
      @command = klass.new(stdout, stdin, stderr, arguments)
      @help_command = HelpCommand.new(stdout, stdin, stderr, [])
    end

    def run
      @command.run
    end

    private

    def get_command_class(command)
      Object.const_get("OAuth::CLI::#{command.camelize}Command")
    end

    def parse_command(command)
      case command = command.to_s.downcase
      when '--version', '-v'
        'version'
      when '--help', '-h', nil, ''
        'help'
      when *ALIASES.keys
        ALIASES[command]
      when *ALIASES.values
        command
      else
        'help'
      end
    end
  end
end
