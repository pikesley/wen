require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'sidekiq'

require 'neoclock'

require_relative 'pixelclock/helpers'
require_relative 'pixelclock/racks'

Sidekiq.options[:concurrency] = 1

module Pixelclock
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
      include Pixelclock::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from Pixelclock</h1>'
          @title = 'Pixelclock'
          @github_url = CONFIG['github_url']
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'Pixelclock'
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
