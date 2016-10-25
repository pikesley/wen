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

namespace :nightwatch do
  task :local do
    require 'dotenv'
    Dotenv.load

    pid = Process.spawn "selenium-server -log /tmp/selenium.log &"
    sleep 3
    sh "nightwatch --config spec/javascripts/support/nightwatch.js --env local"
    sh "pkill -f selenium"
  end

  #task :travis do
  #  sh "nvm install 4.0"
  #  sh "npm install -g nightwatch"
  #  sh "bundle exec sidekiq -r ./lib/wen.rb &"
  #  sh "bundle exec rackup -p 9292 &"
  #  sh "sh 'nightwatch --config spec/javascripts/support/nightwatch.js'"
  #  sh "pkill ruby"
  #end
end
