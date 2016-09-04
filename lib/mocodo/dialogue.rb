module Mocodo
  class Dialogue < Base
    EndPoint = "/dialogue/v1/dialogue"

    attr_reader :config
    def initialize(*args)
      super
      @config = {}
    end
    
    def configure(options = {})
      @config.merge!(options)
    end
    
    def get_current_data(option=nil)
      option.nil? ? @config : @config[option]
    end

    def create_dialogue(talk)
      response = post(build_url(EndPoint), @config.merge(utt: talk).to_json, {'Content-Type' =>'application/json'})
      response = JSON.parse(response, symbolize_names: true)
      configure(response)
      return response[:utt]
    end
  end
end