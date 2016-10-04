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

Sidekiq.options[:concurrency] = 1

module Wen
  class ClockWorker
    include Sidekiq::Worker

    def perform action, params
      case action
      when 'display'
        Neoclock::Clock.send(params['mode'].to_sym)
      end
    end
  end

  class App < Sinatra::Base
    helpers do
      include Wen::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from Wen</h1>'
          @title = 'Wen'
          @github_url = CONFIG['github_url']
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'Wen'
          }.to_json
        end
      end
    end

    patch '/display/?' do
      ClockWorker.perform_async "display", JSON.parse(request.body.read)
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
