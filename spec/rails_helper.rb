require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Require factory_bot_rails
require 'factory_bot_rails'
require 'database_cleaner/active_record'

# Add this custom matcher for query counting
RSpec::Matchers.define :exceed_query_limit do |expected|
  match do |block|
    query_count = 0
    counter = lambda do |name, started, finished, unique_id, data|
      query_count += 1 if data[:sql] !~ /^(?:BEGIN|COMMIT|ROLLBACK|RELEASE SAVEPOINT|SAVEPOINT)/
    end

    ActiveSupport::Notifications.subscribed(counter, 'sql.active_record', &block)

    query_count > expected
  end

  failure_message do |actual|
    "expected block to not exceed #{expected} queries, but it executed #{@query_count} queries"
  end
end

RSpec.configure do |config|
  config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Include Factory Bot syntax methods
  config.include FactoryBot::Syntax::Methods

  # Configure Database Cleaner for factory bot
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
