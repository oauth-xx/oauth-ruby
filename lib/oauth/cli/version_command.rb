# frozen_string_literal: true

module OAuth
  class CLI
    class VersionCommand < BaseCommand
      def run
        puts "OAuth Gem #{OAuth::VERSION}"
      end
    end
  end
end
