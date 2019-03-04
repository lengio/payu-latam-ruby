require "simplecov"
require "coveralls"
require "webmock/rspec"

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
]

SimpleCov.start
Coveralls.wear!

require "pry"
require "bundler/setup"
require "pay_u"

Dir["./spec/fixtures/*.rb"].each { |fixture| require fixture }
Dir["./spec/helpers/*.rb"].each { |fixture| require fixture }

if ENV["CIRCLE_ARTIFACTS"]
  dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
  SimpleCov.coverage_dir(dir)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers
end
