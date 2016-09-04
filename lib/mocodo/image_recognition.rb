require 'httpclient'

module Mocodo
  module ImageRecognize
    class Category < Base
      EndPoint = "/imageRecognition/v1/concept/classify/"
      def recognize(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        JSON.parse(response, symbolize_names: true)
      end
    end
    
    class Object < Base
      EndPoint = "/imageRecognition/v1/recognize"
      def recognize(image, options)
        post(build_url(EndPoint, options), image, {'Content-Type' =>'application/octet-stream'})
      end
    end
  end
end