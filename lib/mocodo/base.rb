require 'net/https'
require 'open-uri'
require 'json'

module Mocodo
  class Base
    BaseURL = "https://api.apigw.smt.docomo.ne.jp"
    
    attr_reader :api_key, :response
    
    def initialize(api_key)
      @api_key = api_key
    end
    
    private
    
    def build_params(options={})
      options.map{|pair|pair.join("=")}.join("&")
    end
    
    def build_url(endpoint, options={})
      uri = URI.parse(File.join(BaseURL, endpoint))
      uri.query = build_params(options.merge(APIKEY: @api_key))
      uri
    end
    
    def post(uri, body, header={})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = body
      http.start do |h|
        h.request(request).body
      end
    end
    
    def get(uri, header={})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri, header)
      http.start do |h|
        h.request(request).body
      end
    end
    
    def delete(uri, body=nil, header={})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Delete.new(uri.request_uri, header)
      request.body = body
      http.start do |h|
        h.request(request).body
      end
    end
  end
end