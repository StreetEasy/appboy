require 'pry'
require 'vcr'
require 'dotenv'
require 'bundler/setup'

Bundler.setup
Dotenv.load

require 'appboy'

VCR.configure do |config|
  config.filter_sensitive_data('<APPBOY_GROUP_ID>') { ENV.fetch('APPBOY_GROUP_ID') }
  config.filter_sensitive_data('<APPBOY_TEST_SEGMENT>') { ENV.fetch('APPBOY_TEST_SEGMENT') }

  config.cassette_library_dir = 'spec/fixtures/responses'

  config.default_cassette_options = {
    match_requests_on: [:method, :uri, :body]
  }

  config.configure_rspec_metadata!

  config.hook_into :webmock
end

require 'support/integrations'

RSpec.configure do |config|
  def test_time
    Time.parse('2015-02-15 00:00:00 -0500')
  end
end
