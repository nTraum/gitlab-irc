require 'optparse'

module GitlabIrc
  class Cli
    def initialize (argv)
      @options = {}

      OptionParser.new do |opts|
        opts.banner = 'Usage: gitlab-irc [options]'

        @options[:init] = false
        opts.on('-i', '--init', 'Initialize program by creating configuration file') do
          @options[:init] = true
        end

        opts.on('-v', '--version', 'Display program version') do
          puts "gitlab-irc #{GitlabIrc::VERSION}"
          exit
        end
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end.parse!
    end
  end
end