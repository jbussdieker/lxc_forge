require 'optparse'

module LxcForge
  class Options
    attr_accessor :options

    def initialize(argv)
      @argv = argv
      @options = {}
    end

    def parser
      OptionParser.new do |opts|
        opts.banner = "Usage: lxc-forge ACTION [options]

Actions:
    configure - Configure LXC Forge settings
    upload    - Upload an LXC container to S3
    download  - Download an LXC container from S3
    list      - List available containers on S3

"

        opts.on("-n NAME", "--name NAME", "Set container name") do |v|
          options[:name] = v
        end

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options[:verbose] = v
        end

        opts.on("-f", "--[no-]force", "Force overwrite") do |v|
          options[:force] = v
        end
      end
    end

    def parse
      parser.parse!(@argv)

      if @argv.length == 0
        puts parser.help
        exit 0
      elsif @argv.length == 1
        options[:command] = @argv.first
      else
        raise ArgumentError.new "Multiple actions not supported"
      end

      options
    end
  end
end
