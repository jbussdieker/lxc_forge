module LxcForge
  class Command
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def run
      start = Time.now
      send(options[:command])
      finish = Time.now
      puts "Completed in #{finish - start} seconds"
    end

    def container
      @container ||= LxcForge::Container.new(options[:name])
    end

    def prompt_yes_no(prompt)
      print prompt
      response = STDIN.gets.chomp()
      raise "Aborted" unless response == "y"
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

    def list
      container.list
    end
  end
end
