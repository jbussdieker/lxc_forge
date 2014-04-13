require 'lxc'
require 'tempfile'
require 'aws-sdk'

module LxcForge
  class Container
    attr_accessor :name

    def initialize(name, config)
      @name = name
      @config = config
    end

    def lxc
      LXC.new
    end

    def lxc_container
      LXC::Container.new(:lxc => lxc, :name => name)
    end

    def list
      bucket.objects.each do |o|
        puts o.key
      end
    end

    def exists?
      lxc_container.exists?
    end

    def destroy
      lxc_container.destroy
    end

    def destroy_remote
      obj.delete
    end

    def remote_exists?
      obj.exists?
    end

    def tmp_file
      @tmp_file ||= (
        name = Dir::Tmpname.make_tmpname "lxc-forge-#{name}", nil
        File.join(Dir::Tmpname.tmpdir, name)
      )
    end

    def compress
      Dir.chdir "/var/lib/lxc"
      count = 0
      IO.popen("tar -zcvf #{tmp_file} #{name} 2>&1") do |io|
        while !io.eof? do
          io.gets
          count += 1
          print "." if count % 200 == 0
        end
      end
      puts
      raise "Error compressing" unless $?.to_i == 0
    end

    def uncompress
      Dir.chdir "/var/lib/lxc"
      count = 0
      IO.popen("tar -zxvf #{tmp_file} 2>&1") do |io|
        while !io.eof? do
          io.gets
          count += 1
          print "." if count % 200 == 0
        end
      end
      puts
      raise "Error uncompressing" unless $?.to_i == 0
    end

    def s3_config
      {
        :access_key_id => config.access_key_id,
        :secret_access_key => config.secret_access_key,
        :region => config.region
      }
    end

    def s3
      AWS::S3.new(s3_config)
    end

    def bucket
      s3.buckets[config.bucket]
    end

    def obj
      bucket.objects[@name]
    end

    def upload
      count = 0
      File.open(tmp_file, 'r') do |file|
        obj.write(:content_length => file.size) do |buffer, bytes|
          count += 1
          print "." if count % 1 == 0
          buffer.write(file.read(bytes))
        end
      end
      puts
    end

    def download
      count = 0
      File.open(tmp_file, 'wb') do |file|
        obj.read do |chunk|
          count += 1
          print "." if count % 500 == 0
          file.write(chunk)
        end
      end
      puts
    end
  end
end
