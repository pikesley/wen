require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'sidekiq'
require 'pixel_pi'
require 'singleton'
require 'ostruct'
require 'git'

require_relative 'wen/clock/clock'
require_relative 'wen/clock/config'
require_relative 'wen/clock/clock'
require_relative 'wen/clock/neopixels'
require_relative 'wen/clock/tricks'

require_relative 'wen/helpers'
require_relative 'wen/racks'
require_relative 'wen/clock_worker'

IS_PI = RUBY_PLATFORM =~ /arm.*-linux/

Sidekiq.options[:concurrency] = 1
$redis = Redis.new

module Wen
  class App < Sinatra::Base
    helpers do
      include Wen::Helpers
    end

    get '/static/:something' do
      File.read(File.join('public', 'html', "#{params[:something]}.html"))
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
         wants.html do
            redirect to '/colours'
         end
      end
    end

    get '/about' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
         wants.html do
            @title = 'About'
            erb :'about'
         end
      end
    end

### colours

    get '/colours/?' do
      respond_to do |wants|
         wants.html do
           @title = 'Colours'
           erb :'colours'
         end

          wants.json do
            Config.instance.config.colours.to_json
          end
      end
    end

    get '/colours/:wheel/:layer' do
      headers 'Vary' => 'Accept'
      {
        'colour' => Wen::Clock.fetch_colour(params[:wheel], params[:layer])
      }.to_json
    end

    post '/colours/reset/?' do
      ClockWorker.perform_async 'reset', {'reset' => 'colours'}
    end

    post '/colours/?' do
      ClockWorker.perform_async 'colours', JSON.parse(request.body.read)
    end

### modes

    get '/mode/?' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @title = 'Clock Modes'
          erb :modes
        end

        wants.json do
          {
            mode: Clock.mode
          }.to_json
        end
      end
    end

    post '/mode/?' do
      ClockWorker.perform_async 'mode', JSON.parse(request.body.read)
    end

### tricks

    get '/tricks/?' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @title = 'Trick Modes'
          erb :tricks
        end
      end
    end

    post '/tricks/?' do
      ClockWorker.perform_async 'tricks', JSON.parse(request.body.read)
    end

### time

    post '/time/?' do
      ClockWorker.perform_async 'time'
    end

    # start the server if ruby file executed directly
    if app_file == $0
      run!
    end
  end

  def self.stash_defaults
    self.stash_colours

    $redis.set 'clock-mode', Wen::Config.instance.config['clock-modes'].first['name']
  end

  def self.stash_colours
    Wen::Config.instance.config.neopixels.each_pair do |wheel, data|
      data['colours'].keys.each do |layer|
        key = "#{wheel}/#{layer}"
        $redis.set key, data['colours'][layer].join(', ')
      end
    end
  end
end
