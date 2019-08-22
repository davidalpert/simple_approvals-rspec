lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'simple_approvals-rspec'
  spec.version       = File.exist?('VERSION') ? File.read('VERSION').strip : ''
  spec.authors       = ['David Alpert']
  spec.email         = ['david@spinthemoose.com']
  spec.description   = 'a simple rspec-based implementation of the ApprovalTests pattern'
  spec.summary       = ''
  spec.homepage      = 'https://github.com/davidalpert/simple_approvals-rspec/'

  spec.files         = `git ls-files -- lib/*`.split("\n")
  spec.files        += %w[README.md]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'geminabox'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'version_bumper'
  spec.add_dependency 'json'
end
