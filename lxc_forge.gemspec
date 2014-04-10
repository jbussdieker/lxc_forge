# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lxc_forge/version'

Gem::Specification.new do |spec|
  spec.name          = "lxc_forge"
  spec.version       = LxcForge::VERSION
  spec.authors       = ["Joshua B. Bussdieker"]
  spec.email         = ["jbussdieker@gmail.com"]
  spec.summary       = %q{Upload and download LXC containers from S3}
  spec.homepage      = "https://github.com/jbussdieker/lxc_forge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "lxc", "~> 0.6"
  spec.add_runtime_dependency "minitar", "~> 0.5"
  spec.add_runtime_dependency "aws-sdk", "~> 1.38"
end
