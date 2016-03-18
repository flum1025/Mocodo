require 'net/https'
require 'open-uri'
require 'json'

module Mocodo
  class Recognize
    
    def initialize(api_key)
      @client = Client.new(api_key)
    end
    
    def image_open(path)
      if /^http/ =~ path
        binary_image = File.binread(open(path))
      else
        binary_image = File.binread(File.open(path))
      end
      return binary_image
    end
        
    def image_recognition(path, num=1)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/imageRecognition/v1/recognize?APIKEY=#{@client.get_api_key}&recog=product-all&numOfCandidates=#{num}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/octet-stream'})
      request.body = File.binread(open(path)) #image_open(path) 
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:candidates]
    end
    
    def local_image_recognition(path, num=1)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/imageRecognition/v1/recognize?APIKEY=#{@client.get_api_key}&recog=product-all&numOfCandidates=#{num}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'application/octet-stream'})
      request.body = File.binread(File.open(path))
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response[:candidates]
    end
  end
end