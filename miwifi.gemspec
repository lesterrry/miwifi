# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miwifi/version'

Gem::Specification.new do |spec|
	spec.name          = 'miwifi'
	spec.version       = Miwifi::VERSION
	spec.authors       = ['Aydar N.']
	spec.email         = ['me@aydar.media']

	spec.required_ruby_version = '>= 2.6.3'

	spec.summary       = 'API wrapper for MiWIFI routers'
	spec.description   = 'Provides authentication methods as well as some simple API calls'
	spec.homepage      = 'https://github.com/lesterrry/miwifi'
	spec.license       = 'MIT'

	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files         = Dir.chdir(File.expand_path(__dir__)) do
		`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	end
	spec.bindir        = 'exe'
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler', '>= 2.2.33'
	spec.add_development_dependency 'irb'
	spec.add_development_dependency 'minitest', '~> 5.0'
	spec.add_development_dependency 'rake', '~> 13.0'
	spec.add_development_dependency 'rubocop'
end