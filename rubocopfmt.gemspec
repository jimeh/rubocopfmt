# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocopfmt/version'
require 'rubocopfmt/rubocop_version'

Gem::Specification.new do |spec|
  spec.name        = 'rubocopfmt'
  spec.version     = RuboCopFMT::VERSION
  spec.authors     = ['Jim Myhrberg']
  spec.email       = ['contact@jimeh.me']

  spec.summary     = 'Easy formatting of Ruby code using RuboCop'
  spec.description = 'Easy formatting of Ruby code using RuboCop'
  spec.homepage    = 'https://github.com/jimeh/rubocopfmt'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test/|spec/|features/|Gemfile\.ci)})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug'

  spec.add_runtime_dependency 'rubocop', RuboCopFMT::RUBOCOP_VERSION
  spec.add_runtime_dependency 'trollop', '~> 2.1.0'
  spec.add_runtime_dependency 'diffy', '~> 3.1.0'
end
