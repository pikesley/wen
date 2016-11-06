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
  desc 'spin up selenium, run the nightwatch tests, tear down selenium'
  task :local do
    pid = Process.spawn "selenium-server -log /tmp/selenium.log &"
    sleep 3
    sh "nightwatch --config spec/javascripts/support/nightwatch.js --env local"
    sh "pkill -f selenium"
  end

  desc 'just run the nightwatch tests (requires a running selenium)'
  task :test do
    sh "nightwatch --config spec/javascripts/support/nightwatch.js --env local"
  end

  desc 'take screenshots'
  task :screenshots do
    pid = Process.spawn "selenium-server -log /tmp/selenium.log &"
    sleep 3
    sh "nightwatch --config spec/javascripts/support/nightwatch.js --env local --test spec/javascripts/screenshots/screenshots.js"
    sh "pkill -f selenium"
    sh "open screenshot"
  end
end

namespace :colours do
  desc 'pull colours from Paletton palette into config'
  task :capture do
    map = {}
    File.readlines('public/sass/_colours.scss').grep(/\$brand/).each do |b|
      parts = b.split(/: */)
      map[parts[0]] = parts[1].strip[0..-2]
    end

    palette = File.readlines "public/sass/#{File.readlines('public/sass/_colours.scss').
                grep(/@import/).first.split(' ')[1].split("'")[1].gsub('/', '/_')}.scss"

    map.each_pair do |k, v|
      map[k] = palette.grep(/#{v[1..-1]}/).last.match(/.*rgba\((.*)\).*/)[1].split(',')[0..2].map { |n| n.to_i }
    end

    y = YAML.load_file 'config/clock.yml'

    y['neopixels']['minutes']['colours']['hand'] = map['$brand-secondary-2']
    y['neopixels']['minutes']['colours']['face'] = map['$brand-complement']
    y['neopixels']['hours']['colours']['hand'] = map['$brand-secondary-2']
    y['neopixels']['hours']['colours']['face'] = map['$brand-complement']

    map.keys.map { |k| y['colours'][k[1..-1]] = map[k] }

    File.open 'config/clock.yml', 'w' do |f|
      f.write y.to_yaml
    end
  end
end

namespace :run do
  desc 'clean-up and start app'
  task :app do
    sh 'redis-cli flushall'
    Rake::Task['colours:capture'].invoke
    sh 'rackup -o 0.0.0.0'
  end

  desc 'clean-up and run compass'
  task :sass do
    sh 'compass clean && compass watch'
  end

  desc 'start redis and run sidekiq'
  task :queue do
    sh 'redis-server &'
    sh 'sidekiq -r ./lib/wen.rb'
  end
end

namespace :svgs do
  task :generate do
    require 'nineteen/eighty/two'

    Wen::Config.instance.config.words.each_pair do |type, words|
      FileUtils.mkdir_p "views/includes/svgs/#{type}"
      words.each_pair do |name, content|
        File.open "views/includes/svgs/#{type}/#{name}.svg.erb", 'w' do |f|
          f.write Nineteen::Eighty::Two::Formats::SVG.format "#{content}",
          {class: type}
        end
      end
    end

    Wen::Config.instance.config['clock-modes'].each do |mode|
      FileUtils.mkdir_p "views/includes/svgs/mode"
      File.open "views/includes/svgs/mode/#{mode['name']}.svg.erb", 'w' do |f|
        f.write Nineteen::Eighty::Two::Formats::SVG.format "#{mode['name']} clock", {class: 'mode'}
      end
    end

    Wen::Config.instance.config['trick-modes'].each do |mode|
      FileUtils.mkdir_p "views/includes/svgs/trick"
      File.open "views/includes/svgs/trick/#{mode['method']}.svg.erb", 'w' do |f|
        text = mode['method']
        text = mode['display_name'] if mode['display_name']
        f.write Nineteen::Eighty::Two::Formats::SVG.format text.split(' '), {class: 'trick'}
      end
    end

    Wen::Config.instance.config['button-text']['modes'].each_pair do |name, text|
      FileUtils.mkdir_p "views/includes/svgs/misc"
      File.open "views/includes/svgs/misc/#{name}.svg.erb", 'w' do |f|
        f.write Nineteen::Eighty::Two::Formats::SVG.format text, {class: 'misc'}
      end
    end

    ['scramble', 'reset'].each do |word|
      FileUtils.mkdir_p "views/includes/svgs/misc"
      File.open "views/includes/svgs/misc/#{word}.svg.erb", 'w' do |f|
        f.write Nineteen::Eighty::Two::Formats::SVG.format word, {class: 'misc'}
      end
    end
  end
end
