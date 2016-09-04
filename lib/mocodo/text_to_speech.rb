module Mocodo
  module TextToSpeech
    module AiTalk
      class AiTalkBase < Base
        EndPoint = "/aiTalk/v1/textToSpeech"
        def header(content)
          {'Content-Type'=>content, 'Accept'=>'audio/L16'}
        end
      end

      class Ssml < AiTalkBase
        def speech text
          post(build_url(EndPoint), text, header('application/ssml+xml'))
        end
      end

      class Kana < AiTalkBase
        def speech text
          post(build_url(EndPoint), text, header('application/x-aitalk-kana'))
        end
      end

      class JeitaKana < AiTalkBase
        def speech text
          post(build_url(EndPoint), text, header('text/x-jeita-6004-kana'))
        end
      end
    end

    class VoiceText < Base
      EndPoint = "/voiceText/v1/textToSpeech"
      
      def speech(options={})
        post(build_url(EndPoint), build_params(options), {'Content-Type'=>'application/x-www-form-urlencoded'})
      end      
    end
    
    module Crayon
      class TextToSpeech < Base
        EndPoint = "/crayon/v1/textToSpeech"
        
        def speech(options={})
          post(build_url(EndPoint), options.to_json, {'Content-Type'=>'application/json'})
        end 
      end
      
      class TextToSpeechSsml < Base
        EndPoint = "/crayon/v1/textToSpeechSsml"
        
        def speech(options={})
          post(build_url(EndPoint), options.to_json, {'Content-Type'=>'application/json'})
        end 
      end
      
      class TextToSpeechKanaAccent < Base
        EndPoint = "/crayon/v1/textToSpeechKanaAccent"
        
        def speech(options={})
          post(build_url(EndPoint), options.to_json, {'Content-Type'=>'application/json'})
        end 
      end
    end
  end
end