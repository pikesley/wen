require 'coveralls'
Coveralls.wear_merged!

require 'rack/test'
require 'rspec-sidekiq'
require 'wen'
require 'timecop'

ENV['TZ'] = 'UTC'
ENV['environment'] = 'test'
JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random

  config.before :each do
    $redis.flushdb

    $face_colour = Wen::Config.instance.config.neopixels['minutes']['colours']['face']
    $hand_colour = Wen::Config.instance.config.neopixels['minutes']['colours']['hand']

    Wen.stash_defaults
  end

  include Rack::Test::Methods
  def app
    Wen::App
  end
end
