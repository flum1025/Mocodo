module Mocodo
  class SentenceUnderstanding < Base
    EndPoint = "/sentenceUnderstanding/v1/task"
    def sentenceUnderstanding(options={})
      post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/x-www-form-urlencoded'})
    end
  end
end