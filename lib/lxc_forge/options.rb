require 'optparse'

module LxcForge
  module Options
    def self.parse(argv)
      options = {}

      OptionParser.new do |opts|
        opts.banner = "Usage: lxc-forge ACTION [options]

Actions:
    upload   - Upload an LXC container to S3
    download - Download an LXC container from S3
    list     - List available containers on S3

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
      end.parse!(argv)

      if argv.length == 0
        raise ArgumentError.new "No action not specified"
      elsif argv.length == 1
        options[:command] = argv.first
      else
        raise ArgumentError.new "Multiple actions not supported"
      end

      options
    end
  end
end
