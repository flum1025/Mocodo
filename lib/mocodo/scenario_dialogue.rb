module Mocodo
  module ScenarioDialogue
    class Registration < Base
      EndPoint = "/scenarioDialogue/v1/registration"
      def registration(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
    
    class Dialogue < Base
      EndPoint = "/scenarioDialogue/v1/dialogue"
      def create_dialogue(options={})
        post(build_url(EndPoint), options.to_json, {'Content-Type' =>'application/json'})
      end
    end
  end
end