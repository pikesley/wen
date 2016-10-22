require 'logger'

module Wen
  class App < Sinatra::Base
    log_path = 'log/'
    log_path = '/var/log/wen/' if IS_PI

    Logger.class_eval { alias :write :'<<' }
    access_log = File.join log_path, 'access.log'
    access_logger = ::Logger.new(access_log)

    configure do
      use ::Rack::CommonLogger, access_logger
    end
  end
end
