require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'sidekiq'
require 'pixel_pi'
require 'singleton'
require 'ostruct'

require_relative 'clockface/clock'
require_relative 'clockface/config'
require_relative 'clockface/clock'
require_relative 'clockface/neopixels'
require_relative 'clockface/tricks'

require_relative 'clockface/helpers'
require_relative 'clockface/racks'

Sidekiq.options[:concurrency] = 1

module Clockface
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
      include Clockface::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from Clockface</h1>'
          @title = 'Clockface'
          @github_url = CONFIG['github_url']
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'Clockface'
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
