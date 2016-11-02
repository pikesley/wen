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
require_relative 'wen/clock_workers'


Sidekiq.options[:concurrency] = 1
$redis = Redis.new

module Wen
  class App < Sinatra::Base
    helpers do
      include Wen::Helpers
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
            erb :'about', layout: !is_pjax?
         end
      end
    end

### colours

    get '/colours/?' do
      respond_to do |wants|
        wants.html do
          @title = 'Colours'
          erb :'colours', layout: !is_pjax?
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
      ColourWorker.perform_async :reset
    end

    post '/colours/?' do
      ColourWorker.perform_async JSON.parse(request.body.read)
    end

### modes

    get '/modes/?' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @title = 'Clock Modes'
          erb :modes, layout: !is_pjax?
        end

        wants.json do
          {
            mode: Clock.mode
          }.to_json
        end
      end
    end

    post '/modes/?' do
      ModeWorker.perform_async JSON.parse(request.body.read)
    end

### tricks

    get '/tricks/?' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @title = 'Trick Modes'
          erb :tricks, layout: !is_pjax?
        end
      end
    end

    post '/tricks/?' do
      TrickWorker.perform_async JSON.parse(request.body.read)
    end

### time

    post '/time/?' do
      TimeWorker.perform_async
    end

    # start the server if ruby file executed directly
    if app_file == $0
      run!
    end

    not_found do
      status 404
      @title = '4:04'
      erb :oops
    end
  end

  def self.stash_defaults
    self.stash_colours

    $redis.set 'clock-mode', Wen::Config.instance.config['clock-modes'].first['name'] unless $redis.get 'clock-mode'
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
