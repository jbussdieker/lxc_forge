require 'spec_helper'

describe LxcForge::Config do
  let(:options) { {} }
  let(:config) { LxcForge::Config.new(options) }
  subject { config }

  its(:config_file) { should == File.join(ENV["HOME"], ".lxc_forge.yml") }
  its(:to_hash) { should == { :access_key_id => nil, :secret_access_key => nil, :region => nil, :bucket => nil } }

end
