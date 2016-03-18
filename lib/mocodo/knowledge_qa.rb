require 'net/https'
require 'json'

module Mocodo
  class KnowledgeQA
    def initialize(api_key)
      @client = Client.new(api_key)
    end
    
    def create_qa qa
      uri = URI.parse("https://api.apigw.smt.docomo.ne.jp/knowledgeQA/v1/ask?APIKEY=#{@client.get_api_key}&q=#{URI.encode(qa)}")
      http = Net::HTTP.new('api.apigw.smt.docomo.ne.jp', 443)
      http.use_ssl = true
      res = http.start {
        http.get(uri.request_uri)
      }
      data = JSON.parse(res.body)
      return data
     end
  end
end