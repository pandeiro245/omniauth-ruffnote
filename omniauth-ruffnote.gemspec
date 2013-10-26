# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/ruffnote/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-ruffnote"
  spec.version       = Omniauth::Ruffnote::VERSION
  spec.authors       = ["pandeiro245"]
  spec.email         = ["pandeiro245@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "https://github.com/pandeiro245/omniauth-ruffnote"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.7'


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
