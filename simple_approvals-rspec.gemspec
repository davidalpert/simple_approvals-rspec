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

  spec.files         = `git ls-files -z`.split("\x0").delete_if { |value| value.include?('lib') }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'geminabox'
  # spec.add_development_dependency "gemspec"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'version_bumper'
  spec.add_dependency 'json', '= 2.1.0' # 2.2.0 fails on windows - requires more investigation
end
