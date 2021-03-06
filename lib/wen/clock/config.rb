module Wen
  class Config
    include Singleton

    def initialize
      reset!
    end

    def reset! # testing a singleton is hard
      @config = OpenStruct.new fetch_yaml 'clock'
    end

    def config
      @config
    end

    def colours
      @colours
    end

    private

    def fetch_yaml file
      YAML.load(File.open(File.join(File.dirname(__FILE__), '..', '..', '..', 'config/%s.yml' % file)))
    end
  end
end
