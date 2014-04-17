require 'spec_helper'

describe LxcForge::Container do
  let(:name) { "test-container" }
  let(:options) { {} }
  let(:config) { LxcForge::Config.new(options) }
  let(:container) { LxcForge::Container.new(name, config) }
  subject { container }

  its(:name) { should == name }
  its(:config) { should == config }
  its(:lxc) { should be_kind_of LXC }
  its(:lxc_container) { should be_kind_of LXC::Container }
  
  describe "list" do
    # TODO
  end

  describe "exists?" do
    let(:lxc_container) { double().as_null_object }
    before { container.stub(:lxc_container).and_return(lxc_container) }

    context "when container exists" do
      before { lxc_container.stub(:exists?).and_return(true) }
      its(:exists?) { should == true }
    end

    context "when container does not exist" do
      before { lxc_container.stub(:exists?).and_return(false) }
      its(:exists?) { should == false }
    end
  end

  describe "destroy" do
    let(:lxc_container) { double().as_null_object }
    before { container.stub(:lxc_container).and_return(lxc_container) }

    it "calls destroy on lxc_container" do
      lxc_container.should_recieve(:destroy)
      subject.destroy
    end
  end

  describe "destroy_remote" do
    let(:obj) { double().as_null_object }
    before { container.stub(:obj).and_return(obj) }

    it "calls delete on obj" do
      obj.should_recieve(:delete)
      subject.destroy_remote
    end
  end

  describe "remote_exists?" do
    let(:obj) { double().as_null_object }
    before { container.stub(:obj).and_return(obj) }

    it "calls exists? on obj" do
      obj.should_recieve(:exists?)
      subject.remote_exists?
    end
  end

  describe "tmp_file" do
    its(:tmp_file) { should start_with "/tmp/lxc-forge-" }
  end

  its(:s3_config) { should == {:access_key_id => nil, :region => nil, :secret_access_key => nil} }
  its(:s3) { should be_kind_of AWS::S3 }
  its(:bucket) { should be_kind_of AWS::S3::Bucket }
  its(:obj) { should be_kind_of AWS::S3::S3Object }
end
