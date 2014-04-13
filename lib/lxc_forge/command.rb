module LxcForge
  class Command
    attr_accessor :config, :options

    def initialize(config, options)
      @config = config
      @options = options
    end

    def run
      start = Time.now
      send(options[:command])
      finish = Time.now
      puts "Completed in #{finish - start} seconds" if options[:verbose]
    end

    def container
      @container ||= LxcForge::Container.new(options[:name], config)
    end

    def prompt(msg)
      print msg
      STDIN.gets.chomp()
    end

    def prompt_yes_no(msg)
      raise "Aborted" unless prompt(msg) == "y"
    end

    def upload
      raise "Container doesn't exist" unless container.exists?

      if container.remote_exists?
        prompt_yes_no "Remote file already exists. Replace it (y/n) " unless options[:force]
        container.destroy_remote
      end

      print "Compressing..."
      container.compress
      print "Uploading..."
      container.upload
    end

    def download
      raise "Remote file doesn't exist" unless container.remote_exists?

      if container.exists?
        prompt_yes_no "Container already exists. Replace it (y/n) " unless options[:force]
        container.destroy
      end

      print "Downloading..."
      container.download
      print "Installing..."
      container.uncompress
    end

    def configure
      config = Config.new(options)
      config.access_key_id = prompt("Access Key ID: ")
      config.secret_access_key = prompt("Secret Access Key: ")
      config.region = prompt("Region: ")
      config.bucket = prompt("Bucket: ")
      config.save
      puts "Configuration Saved"
    end

    def list
      container.list
    end
  end
end
