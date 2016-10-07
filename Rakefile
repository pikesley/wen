require File.join(File.dirname(__FILE__), 'lib/wen.rb')
require 'httparty'

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  require 'coveralls/rake/task'
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'

  RSpec::Core::RakeTask.new
  Coveralls::RakeTask.new

  task :default => [:spec, 'jasmine:ci', 'coveralls:push']
end

namespace :clock do
  desc 'Hit the URL to make the clock show the time'
  task :hit do
    url = 'http://localhost:9292/display'
    HTTParty.patch url,
                   headers: {
                     'Content-Type' => 'application/json'
                   },
                   body: {
                     mode: 'time'
                   }.to_json
  end
end
