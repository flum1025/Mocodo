module Mocodo
  module WebCuration
    class Genre < Base
      EndPoint = "/webCuration/v3/genre"
      def get(options={})
        JSON.parse(open(build_url(EndPoint, options)).read, symbolize_names: true)
      end
    end
    
    class Contents < Base
      EndPoint = "/webCuration/v3/contents"
      def get(options={})
        JSON.parse(open(build_url(EndPoint, options)).read, symbolize_names: true)
      end
    end
    
    class RelatedContents < Base
      EndPoint = "/webCuration/v3/relatedContents"
      def get(options={})
        JSON.parse(open(build_url(EndPoint, options)).read, symbolize_names: true)
      end
    end
    
    class Search < Base
      EndPoint = "/webCuration/v3/search"
      def get(options={})
        JSON.parse(open(build_url(EndPoint, options)).read, symbolize_names: true)
      end
    end
  end
end