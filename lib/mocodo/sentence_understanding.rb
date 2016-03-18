require 'net/https'
require 'json'

module Mocodo
  class SentenceUnderstanding
    attr_accessor :config

    def initialize(api_key)
      @client = Client.new(api_key)
      self.config = {}
    end

    def configure(options = {})
      options.each do |key, value|
        self.config[key] = value
      end
    end
    
    def get_current_data(option=nil)
      if option.nil?
        return self.config
      else
        return self.config[option]
      end
    end
    
    def build_body(talk)
      body = {}
      self.config.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['userUtterance'] = {}
      body['userUtterance']['utteranceText'] = talk
      return body.to_json
    end
    
    def sentenceUnderstanding talk
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/sentenceUnderstanding/v1/task?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/x-www-form-urlencoded'})
      request.body = build_body(talk)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      configure(response)
      return response
     end
  end
end