require 'httpclient'

module Mocodo
  module CharacterRecognition
    class Scene < Base
      EndPoint = "/characterRecognition/v1/scene"
      attr_reader :id
      def request(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        response = JSON.parse(response, symbolize_names: true)
        @id = response[:job][:@id]
        response
      end

      def result
        JSON.parse(open(build_url(File.join(EndPoint, @id))).read, symbolize_names: true)
      end

      def cancel
        delete(build_url(File.join(EndPoint, @id)))
      end
    end

    class Line < Base
      EndPoint = "/characterRecognition/v1/line"
      def request(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        JSON.parse(response, symbolize_names: true)
      end
    end

    class Document < Base
      EndPoint = "/characterRecognition/v1/document"
      def request(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        response = JSON.parse(response, symbolize_names: true)
        @id = response[:job][:@id]
        response
      end

      def result
        JSON.parse(open(build_url(File.join(EndPoint, @id))).read, symbolize_names: true)
      end

      def cancel
        delete(build_url(File.join(EndPoint, @id)))
      end
    end
    
    class Layout < Base
      EndPoint = "/characterRecognition/v1/layout"
      def request(options={})
        response = HTTPClient.new.post_content(build_url(EndPoint), options, {
          "content-type" => "multipart/form-data; boundary=boundary",
        })
        JSON.parse(response, symbolize_names: true)
      end
    end
  end
end