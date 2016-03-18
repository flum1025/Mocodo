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
        #image = File.binread(open(path))
        image = open(path)
      else
        #image = File.binread(File.open(path))
        image = File.open(path)
      end
      return image
    end
  end
  
  class SceneRecognition < Recognize
    attr_accessor :id
    
    def recognitionRequest path
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/scene?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'multipart/form-data; boundary=myboundary'})
      form_data = MultiPartFormDataStream.new("image", File.basename(path), image_open(path))
      request.body_stream = form_data
      request["Content-Length"] = form_data.size
      request["Content-Type"] = form_data.content_type
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      self.id = response[:job][:id]
      return response
    end
    
    def getRecognition(id=self.id)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/scene/#{id}?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
    
    def cancelRecognition(id=self.id)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/scene/#{id}?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Delete.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class Line < Recognize
    def get_line path
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/line?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'multipart/form-data; boundary=myboundary'})
      form_data = MultiPartFormDataStream.new("image", File.basename(path), image_open(path))
      request.body_stream = form_data
      request["Content-Length"] = form_data.size
      request["Content-Type"] = form_data.content_type
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class DocumentRecognition < Recognize
    attr_accessor :id
    
    def recognitionRequest path
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/document?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'multipart/form-data; boundary=myboundary'})
      form_data = MultiPartFormDataStream.new("image", File.basename(path), image_open(path))
      request.body_stream = form_data
      request["Content-Length"] = form_data.size
      request["Content-Type"] = form_data.content_type
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      self.id = response[:job][:id]
      return response
    end
    
    def getRecognition(id=self.id)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/document/#{id}?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
    
    def cancelRecognition(id=self.id)
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/document/#{id}?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Delete.new(uri.request_uri)
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class Layout < Recognize
    def get_layout path
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/characterRecognition/v1/layout?APIKEY=#{@client.get_api_key}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' =>'multipart/form-data; boundary=myboundary'})
      form_data = MultiPartFormDataStream.new("image", File.basename(path), image_open(path))
      request.body_stream = form_data
      request["Content-Length"] = form_data.size
      request["Content-Type"] = form_data.content_type
      response = nil
      http.start do |h|
        response = JSON.parse(h.request(request).body, symbolize_names: true)
      end
      return response
    end
  end
  
  class MultiPartFormDataStream
    def initialize(name, filename, file, boundary=nil)
      @boundary = boundary || "boundary"
      first = [boundary_line, content_disposition(name, filename), "", ""].join(new_line)
      last = ["", boundary_last, ""].join(new_line)
      @first = StringIO.new(first)
      @file = file
      @last = StringIO.new(last)
      @size = @first.size + @file.size + @last.size
    end
    def content_type
      "multipart/form-data; boundary=#{@boundary}"
    end
    def boundary_line
      "--#{@boundary}"
    end
    def boundary_last
      "--#{@boundary}--"
    end
    def content_disposition(name, filename)
      "content-disposition: form-data; name=\"#{name}\"; filename=\"#{filename}\""
    end
    def new_line
      "\r\n"
    end
    def read(len=nil, buf=nil)
      return @first.read(len, buf) unless @first.eof?
      return @file.read(len, buf) unless @file.eof?
      return @last.read(len, buf)
    end
    def size
      @size
    end
    def eof?
      @last.eof?
    end
  end
end