require 'net/https'
require 'json'

module Mocodo
  class WebCuration
    def initialize(api_key)
      @client = Client.new(api_key)
    end
    
    def build_url(options = {})
      url = ""
      options.each do |key, value|
        url << "&" << key.id2name << "=" << value
      end
      return URI.escape(url)
    end
  end
  
  class Genre < WebCuration
    def get_genre(conf = {})
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/webCuration/v3/genre?APIKEY=#{@client.get_api_key}#{build_url(conf)}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class Contents < WebCuration
    def get_contents(conf = {})
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/webCuration/v3/contents?APIKEY=#{@client.get_api_key}#{build_url(conf)}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class Search < WebCuration
    def search_contents(conf = {})
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/webCuration/v3/search?APIKEY=#{@client.get_api_key}#{build_url(conf)}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class RelatedContents < WebCuration
    def relatedContents(conf = {})
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/webCuration/v3/relatedContents?APIKEY=#{@client.get_api_key}#{build_url(conf)}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
end