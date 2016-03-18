require 'net/https'
require 'open-uri'
require 'json'

module Mocodo
  class VirtualNarrator
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
    
    def build_body(text)
      body = {}
      self.config.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['TextData'] = text
      return body.to_json
    end
  end
  
  class TextToSpeech < VirtualNarrator
    def textToSpeech text
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/virtualNarrator/v1/textToSpeech?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(text)
      response = nil
      http.start do |h|
        response = h.request(request).body
      end
      return response
    end
  end
  
  class TextToSpeechSsml < VirtualNarrator
    def textToSpeech text
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/virtualNarrator/v1/textToSpeechSsml?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(text)
      response = nil
      http.start do |h|
        response = h.request(request).body
      end
      return response
    end
  end
  
  class TextToSpeechKanaAccent < VirtualNarrator
    def textToSpeech text
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/virtualNarrator/v1/textToSpeechKanaAccent?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(text)
      response = nil
      http.start do |h|
        response = h.request(request).body
      end
      return response
    end
  end
end