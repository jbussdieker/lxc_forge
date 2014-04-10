module LxcForge
  class Container
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def compress
      require 'zlib'
      require 'archive/tar/minitar' 
      Dir.chdir "/var/lib/lxc"
      File.open("/tmp/#{@name}.tar", 'wb') do |f|
        tar = Archive::Tar::Minitar::Output.new(f)
        list = Find.find(@name)
        #list.count
        list.each do |entry|
          puts entry
          unless entry =~ /\/rootfs\/dev\/core$/
            begin
              Archive::Tar::Minitar.pack_file(entry, tar)
            rescue Exception => e
              puts e.message
            end
          end
        end
      end
    end

    def upload
      require 'aws-sdk'
      s3 = AWS::S3.new(
        :access_key_id => '',
        :secret_access_key => '')

      bucket = s3.buckets[""]
      obj = bucket.objects[@name]
      obj.write(Pathname.new("/tmp/#{@name}.tar"))
    end
  end
end
