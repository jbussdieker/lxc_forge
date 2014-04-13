require 'yaml'

module LxcForge
  class Config
    attr_accessor :access_key_id, :secret_access_key, :region, :bucket

    def load(filename)
      data = File.read(filename)
      c = YAML.load(data)
      c.each do |k, v|
        send("#{k}=", v)
      end
    end
  end
end
