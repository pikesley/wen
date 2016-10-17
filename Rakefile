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

namespace :code do
  desc 'Check for and install new code'
  task :update do
    require 'travis'
    require 'git'

    g = Git.open '.'
    remote = g.remotes.first.url.sub(/.*github.com./, '').split('.').first
    repository = Travis::Repository.find remote
    last_good_build = repository.builds.select do |b|
      b.branch_info == 'master' && b.state == 'passed'
    end.first.id

    unless $redis.get('last-good-build').to_i == last_good_build
      puts 'New build found'
      `cd ~/wen && git pull && /usr/local/bin/bundle && sudo systemctl restart wen.target`
      $redis.set 'last-good-build', last_good_build
    end
  end
end
