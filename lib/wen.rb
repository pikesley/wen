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

module Wen
  class App < Sinatra::Base
    helpers do
      include Wen::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      @content = '<h1>Hello from Wen</h1>'
      @title = 'Wen'
      @github_url = CONFIG['github_url']
      erb :index, layout: :default
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
