module Mocodo
  module LanguageAnalysis
    class Morph < Base
      EndPoint = "/gooLanguageAnalysis/v1/morph"
      def analysis(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Entity < Base
      EndPoint = "/gooLanguageAnalysis/v1/entity"
      def extract(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Similarity < Base
      EndPoint = "/gooLanguageAnalysis/v1/similarity"
      def calculate(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Hiragana < Base
      EndPoint = "/gooLanguageAnalysis/v1/hiragana"
      def convert(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Shortsum < Base
      EndPoint = "/gooLanguageAnalysisCorp/v1/shortsum"
      def sum(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Keyword < Base
      EndPoint = "/gooLanguageAnalysisCorp/v1/keyword"
      def extract(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    module Truetext
      class Clusteranalytics < Base
        EndPoint = "/truetext/v1/clusteranalytics"
        def analysis(options={})
          post(build_url(EndPoint), build_params(options.merge(text: URI.escape(options[:text]))), {'Content-Type' =>'application/x-www-form-urlencoded'})
        end
      end
      
      class Sensitivecheck < Base
        EndPoint = "/truetext/v1/sensitivecheck"
        def analysis(options={})
          post(build_url(EndPoint), build_params(options.merge(text: URI.escape(options[:text]))), {'Content-Type' =>'application/x-www-form-urlencoded'})
        end
      end
    end
  end
end