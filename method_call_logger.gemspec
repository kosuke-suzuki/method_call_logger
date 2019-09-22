lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "method_call_logger/version"

Gem::Specification.new do |spec|
  spec.name          = "method_call_logger"
  spec.version       = MethodCallLogger::VERSION
  spec.authors       = ["Kosuke Suzuki"]
  spec.email         = ["kosuke.suzuki.127@gmail.com"]

  spec.summary       = %q{Logging each method call of a class}
  spec.description   = %q{Logging each method call of a class}
  spec.homepage      = "https://github.com/kosuke-suzuki/method_call_logger"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kosuke-suzuki/method_call_logger.git"
  spec.metadata["changelog_uri"] = "https://github.com/kosuke-suzuki/method_call_logger/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
