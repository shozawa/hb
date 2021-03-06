# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hb/version'

Gem::Specification.new do |spec|
  spec.name          = "hb"
  spec.version       = Hb::VERSION
  spec.authors       = ["shozawa"]
  spec.email         = ["t.shozawa@mugenup.com"]

  spec.summary       = "Simple Hash Builder (=Presenter) for Rails API"
  spec.homepage      = "https://github.com/shozawa/hb"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "activesupport", ">= 3.0.0"
end
