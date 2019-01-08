$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "pay_u/version"

Gem::Specification.new do |spec|
  spec.name = "payu-latam"
  spec.version = PayU::VERSION
  spec.required_ruby_version = ">= 2.1.0"
  spec.summary = "Ruby bindings for the PayU Latam API"
  spec.description = "Accept payments with PayU Latam: http://developerspec.payulatam.com/es/."
  spec.author = "Slang"
  spec.email = "engineering@slang.com"
  spec.homepage = "https://slangapp.com"
  spec.license = "MIT"

  spec.add_dependency "virtus", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_development_dependency "coveralls", "~> 0"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "pry-byebug", "~> 3.6"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0"
  spec.add_development_dependency "rubocop", "0.57"
  spec.add_development_dependency "simplecov", "~> 0"
  spec.add_development_dependency "webmock", "~> 1.9"

  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- spec/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| ::File.basename(f) }
  spec.require_paths = ["lib"]
end
