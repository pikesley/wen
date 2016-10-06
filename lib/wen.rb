require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'sidekiq'
require 'pixel_pi'
require 'singleton'
require 'ostruct'

require_relative 'wen/clock/clock'
require_relative 'wen/clock/config'
require_relative 'wen/clock/clock'
require_relative 'wen/clock/neopixels'
require_relative 'wen/clock/tricks'

require_relative 'wen/helpers'
require_relative 'wen/racks'
require_relative 'wen/clock_worker'

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

    get '/display/?' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          erb :display, layout: :default
        end
      end
    end

    get '/colours/?' do
      respond_to do |wants|
         wants.html do
            redirect to '/colours/spectrum'
         end
      end
    end

    get '/colours/picker' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          erb :'colours/picker', layout: :default
        end
      end
    end

    get '/colours/spectrum' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          erb :'colours/spectrum', layout: :default
        end
      end
    end

    get '/colours/:wheel/:layer' do
      headers 'Vary' => 'Accept'
      {
        'colour' => Wen::Clock.fetch_colour(params[:wheel], params[:layer])
      }.to_json
    end

    patch '/display/?' do
      ClockWorker.perform_async 'display', JSON.parse(request.body.read)
    end

    patch '/colours/reset/?' do
      ClockWorker.perform_async 'reset', JSON.parse(request.body.read)
    end

    patch '/colours/?' do
      ClockWorker.perform_async 'colours', JSON.parse(request.body.read)
    end

    # start the server if ruby file executed directly
    if app_file == $0
      run!
    end
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
