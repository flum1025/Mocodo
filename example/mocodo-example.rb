# Coding: UTF-8
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mocodo'

api_key = ''

###Mocodoの使用例
####詳しい説明は https://github.com/flum1025/Mocodo
####apiについての説明は https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=image_recognition&p_name=api_usage_scenario
####公式サイトは https://dev.smt.docomo.ne.jp/?p=index

###Copyright c @flum_ 2015
###Twitter:@flum https://twitter.com/flum_
###WEBサイト http://flum.pw/

###画像認識
recognize = Mocodo::Recognize.new(api_key)
p recognize.image_recognition('http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg') #WEB上のがそうURL
p recognize.local_image_recognition(File.join(path, 'mocodo/hqdefault.jpg')) #ローカルの画像パス
###発話理解
  sentence = Mocodo::SentenceUnderstanding.new(api_key)
  sentence.configure config = {
    :projectKey=> "OSU",
    :appInfo=> {
      :appName=> "hoge_app",
      :appKey=> "hoge_app01"
    },
    :clientVer=> "1.0.0",
    :dialogMode=> "off",
    :language=> "ja",
    :userId=> "fly",
    :location=> {
      :lat=> "139.766084",
      :lon=> "35.681382",
    },
  }
  sentence.sentenceUnderstanding("電話して")
  sentence.get_current_data

###音声合成
  ###共通概要
    #レスポンスは全てbinary形式です。
  ###漢字かな混じり文
    textToSpeech = Mocodo::TextToSpeech.new(api_key)
    textToSpeech.configure config = {
      :Command=> "AP_Synth",
      :SpeechRate=> "1.15",
      :AudioFileFormat=> "0",
    }
    binary1 = textToSpeech.textToSpeech "のあちゃんかわいい"
  ###SSML
    textToSpeechSsml = Mocodo::TextToSpeechSsml.new(api_key)
    binary2 = textToSpeechSsml.textToSpeech "ゆあちゃんかわいい"
  ###カナアクセント文
    textToSpeechKanaAccent = Mocodo::TextToSpeechKanaAccent.new(api_key)
    binary3 = textToSpeechKanaAccent.textToSpeech "ふらんちゃんちゃんかわいい"
    
###文字認識
  ###共通概要
    #現時点ではエラーが出て使えません。lib/characterRecognition.rb内のimage_openでの画像の読み込み方法を変えれば、全てのメソッドが使えるようになりそうですが、いまいちわからないのでこのまま。
    #わかる方いたらプルリクお願いします。
  ###情景画像認識要求
    scene = Mocodo::SceneRecognition.new(api_key)
    scene.recognitionRequest('http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg')
  ###情景画像認識結果取得
    #scene.getRecognition #recognitionRequestを実行していればidは自動で入力されます。引数で直接指定もできます。
  ###情景画像認識取消
    #scene.cancelRecognition #recognitionRequestを実行していればidは自動で入力されます。引数で直接指定もできます。
  ###行画像認識要求
    line = Mocodo::Line.new(api_key)
    line.get_line('http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg')
  ###文章画像認識要求
    document = Mocodo::DocumentRecognition.new(api_key)
    document.recognitionRequest('http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg')
  ###文章画像認識結果取得
    #document.getRecognition #recognitionRequestを実行していればidは自動で入力されます。引数で直接指定もできます。
  ###文章画像認識取消
    #document.cancelRecognition #recognitionRequestを実行していればidは自動で入力されます。引数で直接指定もできます。
  ###文章画像レイアウト認識要求
    layout = Mocodo::Layout.new(api_key)
    layout.get_layout('http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg')

###言語解析
  ###形態素解析
    morph = Mocodo::Morph.new(api_key)
    morph.configure config={
      :request_id=>"record001",
      :info_filter=>"form"
    }
    morph.morph "たおはホモ"
  ###固定表現抽出
    entity = Mocodo::Entity.new(api_key)
    entity.configure config={
      :class_filter=>"ART|ORG|PSN|LOC|DAT|TIM"
    }
    entity.entity "ふらんはノンケ"
  ###語句類似度算出
    similarity = Mocodo::Similarity.new(api_key)
    similarity.similarity "のあちゃん","ゆあちゃん"
  ###ひらがな化
    hiragana = Mocodo::Hiragana.new(api_key)
    hiragana.configure config={
      :output_type=>"hiragana"
    }
    hiragana.hiragana "Fラン私立大学"

###雑談対話
  dialogue = Mocodo::Dialogue.new(api_key)
  dialogue.configure config = {
    :mode=>"dialog",
    :context=>"1234567890",
  }
  dialogue.create_dialogue "こんにちは"
  dialogue.get_current_data

###トレンド記事抽出
  ###ジャンル情報の取得
    genre = Mocodo::Genre.new(api_key)
    genre.get_genre
  ###記事取得
    contents = Mocodo::Contents.new(api_key)
    contents.get_contents config={
      :genreId=>"1",
    }
  ###キーワード検索
    search = Mocodo::Search.new(api_key)
    search.search_contents config={
      :keyword=>"ラーメン"
    }
    
###知識Q&A
  qa = Mocodo::KnowledgeQA.new(api_key)
  qa.create_qa "今日は何日"