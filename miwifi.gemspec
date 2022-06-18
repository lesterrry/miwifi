# 
# COPYRIGHT LESTER COVEY,
#
# 2022

require_relative "lib/miwifi/version"

Gem::Specification.new do |spec|
	spec.name = "miwifi"
	spec.version = Miwifi::VERSION
	spec.authors = ["Lester Covey"]
	spec.email = ["me@lestercovey.ml"]

	spec.summary = "API wrapper for MiWIFI routers (beta)"
	spec.description = "Provides authentication methods as well as some simple API calls"
	spec.homepage = "https://github.com/lesterrry/miwifi"
	spec.license = "BSL-1.0"
	spec.required_ruby_version = ">= 2.6.0"

	spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/lesterrry"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/lesterrry/miwifi"

	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files = Dir.chdir(__dir__) do
		`git ls-files -z`.split("\x0").reject do |f|
			(f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
		end
	end
	spec.bindir = "exe"
	spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	# For more information and examples about making a new gem, check out our
	# guide at: https://bundler.io/guides/creating_gem.html
end
