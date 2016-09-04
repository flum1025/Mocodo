module Mocodo
  module MountainIdentification
    class RidgeRendering < Base
      EndPoint = "/mountainIdentification/v1/ridgeRendering"
      def rendering(options={})
        response = get(build_url(EndPoint, options), {'Content-Type' =>'application/json'})
        JSON.parse(response, symbolize_names: true)
      end
    end
    
    class RidgeMatching < Base
      EndPoint = "/mountainIdentification/v1/ridgeMatching"
      def get(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        JSON.parse(response, symbolize_names: true)
      end
    end
    
    class RidgeRecognition < Base
      EndPoint = "/mountainIdentification/v1/ridgeRecognition"
      def get(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        JSON.parse(response, symbolize_names: true)
      end
    end
  end
end