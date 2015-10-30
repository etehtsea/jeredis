require 'redis'
require 'database_cleaner'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end

  config.example_status_persistence_file_path = "spec/failures.txt"
  config.disable_monkey_patching!
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 2
  config.order = :random
  Kernel.srand config.seed

  config.before(:suite) do
    DatabaseCleaner[:redis].strategy = :truncation, { only: %w(jeredis) }
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
