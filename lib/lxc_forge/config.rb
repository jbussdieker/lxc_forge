require 'yaml'

module LxcForge
  class Config
    attr_accessor :options, :access_key_id, :secret_access_key, :region, :bucket

    def initialize(options)
      @options = options
    end

    def config_file
      File.join(ENV["HOME"], ".lxc_forge.yml")
    end

    def load
      load_file(config_file)
    end

    def to_hash
      {
        :access_key_id => access_key_id,
        :secret_access_key => secret_access_key,
        :region => region,
        :bucket => bucket
      }
    end

    # TODO: Break up
    def save
      File.open(config_file, 'w') do |f|
        f.write(to_hash.to_yaml)
      end
    end

    # TODO: Break up
    def load_file(filename)
      data = File.read(filename)
      c = YAML.load(data)
      c.each do |k, v|
        send("#{k}=", v)
      end
    end
  end
end
