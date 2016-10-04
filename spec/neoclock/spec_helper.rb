$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'neoclock'

require 'timecop'
require 'coveralls'
Coveralls.wear!

ENV['TZ'] = 'UTC'
