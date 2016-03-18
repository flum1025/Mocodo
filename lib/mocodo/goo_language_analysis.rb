require 'net/https'
require 'json'

module Mocodo
  class GooLanguageAnalysis
    attr_accessor :config_m, :config_e, :config_s, :config_h
    
    def initialize(api_key)
      @client = Client.new(api_key)
      self.config_m = self.config_e = self.config_s = self.config_h = {}
    end
  end
  
  class Morph < GooLanguageAnalysis
    def configure(options = {})
      options.each do |key, value|
        self.config_m[key] = value
      end
    end
    
    def get_current_data(option=nil)
      if option.nil?
        return self.config_m
      else
        return self.config_m[option]
      end
    end
    
    def build_body(sentence)
      body = {}
      self.config_m.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['sentence'] = sentence
      return body.to_json
    end
    
    def morph sentence
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/morph?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(sentence)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:word_list]
    end
  end
  
  class Entity < GooLanguageAnalysis
    def configure(options = {})
      options.each do |key, value|
        self.config_e[key] = value
      end
    end
    
    def get_current_data(option=nil)
      if option.nil?
        return self.config_e
      else
        return self.config_e[option]
      end
    end
    
    def build_body(sentence)
      body = {}
      self.config_e.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['sentence'] = sentence
      return body.to_json
    end
    
    def entity sentence
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/entity?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(sentence)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:ne_list]
    end
  end
  
  class Similarity < GooLanguageAnalysis
    def configure(options = {})
      options.each do |key, value|
        self.config_s[key] = value
      end
    end
    
    def get_current_data(option=nil)
      if option.nil?
        return self.config_s
      else
        return self.config_s[option]
      end
    end
    
    def build_body(sentence1, sentence2)
      body = {}
      self.config_s.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['query_pair'] = [sentence1, sentence2]
      return body.to_json
    end
    
    def similarity(sentence1, sentence2)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/similarity?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(sentence1, sentence2)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:score]
    end
  end
  
  class Hiragana < GooLanguageAnalysis
    def configure(options = {})
      options.each do |key, value|
        self.config_h[key] = value
      end
    end
    
    def get_current_data(option=nil)
      if option.nil?
        return self.config_h
      else
        return self.config_h[option]
      end
    end
    
    def build_body(sentence)
      body = {}
      self.config_h.each { |sym|
        body[sym[0].id2name] = sym[1]
      }
      body['sentence'] = sentence
      return body.to_json
    end
    
    def hiragana sentence
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/gooLanguageAnalysis/v1/hiragana?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/json'})
      request.body = build_body(sentence)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:converted]
    end
  end
end