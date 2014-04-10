require 'spec_helper'

describe LxcForge::Container do
  let(:name) { "test-container" }
  let(:container) { LxcForge::Container.new(name) }
  subject { container }

  its(:name) { should == name }
end
