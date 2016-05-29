class OAuth::CLI
  class VersionCommand < BaseCommand
    def run
      puts "OAuth for Ruby #{OAuth::VERSION}"
    end
  end
end
