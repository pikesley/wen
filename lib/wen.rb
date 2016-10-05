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
           redirect to '/display'
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
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          erb :colours, layout: :default
        end
      end
    end

    get '/colours/:wheel/:layer' do
      headers 'Vary' => 'Accept'
#      respond_to do |wants|
#        wants.json do
      {
        'colour' => Wen::Config.instance.config.neopixels[params[:wheel]]['colours'][params[:layer]]
      }.to_json
#        end
#      end
    end

    patch '/display/?' do
      ClockWorker.perform_async 'display', JSON.parse(request.body.read)
    end

    patch '/colours/?' do
      ClockWorker.perform_async 'colours', JSON.parse(request.body.read)
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
