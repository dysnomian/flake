# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flake/version'

Gem::Specification.new do |spec|
  spec.name          = "flake"
  spec.version       = Flake::VERSION
  spec.authors       = ["Liss McCabe"]
  spec.email         = ["liss@eristiccode.com"]

  spec.summary       = %q{Make methods flaky, but deterministically.}
  spec.homepage      = "https://github.com/dysnomian/flake"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
end
