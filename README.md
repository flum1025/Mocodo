# Mocodo

docomoAPIのクライアントライブラリです。
apiについての説明は[API共通ガイドライン](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=image_recognition&p_name=api_usage_scenario)へ  
公式サイトは[docomo Developer support](https://dev.smt.docomo.ne.jp/)  

質問等ありましたらTwitter:[@flum_](https://twitter.com/flum_)までお願いします。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mocodo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mocodo

## Usage
### 雑談対話
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=dialogue&p_name=api_1#tag01

```ruby
  dialogue = Mocodo::Dialogue.new(api_key)
  dialogue.configure t: 20 #パラメーターを指定する場合
  puts dialogue.create_dialogue("おはよう")
  puts dialogue.get_current_data #レスポンスパラメーターを取得する場合
```
  
### 知識Q&A
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=knowledge_qa&p_name=api_1#tag01
```ruby
  qa = Mocodo::KnowledgeQA.new(api_key)
  p qa.create_qa("今日は何日")
```
  
### 音声合成
#### Powered by エーアイ
##### SSML
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_1#tag01
```ruby
  ssml = Mocodo::TextToSpeech::AiTalk::Ssml.new(api_key)
  bin = ssml.speech'<?xml version="1.0" encoding="utf-8" ?>
  <speak version="1.1">
  <voice name="nozomi">
  のぞみです。おはようございます。
  </voice>
  <break time="1000ms" />
  <voice name="seiji">
  せいじです。こんにちは。
  </voice>
  </speak>'
  File.binwrite("/Users/flum/Desktop/test.bin", bin)
```
##### 中間言語(AIカナ)
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_2#tag01
```ruby
  kana = Mocodo::TextToSpeech::AiTalk::Kana.new(api_key)
  bin = kana.speech'<S>(VOICE REQUIRED=nozomi_16)|0ノ^ゾミデ!スス<F><S>オ^ハヨーゴザイマ!ス<F><S>(SILENCE MSEC=1000)<F><S>(VOICE REQUIRED=seiji_16)|0セ!イジデス<F><S>コ^ンニチワ<F>'
  File.binwrite("/Users/flum/Desktop/test.bin", bin)
```
##### JEITAカナ
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_6#tag01
```ruby
  jk = Mocodo::TextToSpeech::AiTalk::JeitaKana.new(api_key)
  bin = jk.speech"ﾉｿﾞﾐﾃﾞ'ｽ｡ｵﾊﾖｰｺﾞｻﾞｲﾏ'ｽ｡｡ ｾ'ｲｼﾞﾃﾞｽ｡ｺﾝﾆﾁﾜ｡"
  File.binwrite("/Users/flum/Desktop/test.bin", bin)
```
#### Powered by HOYAサービス
##### 音声合成
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_hoya#tag01
```ruby
  vt = Mocodo::TextToSpeech::VoiceText.new(api_key)
  bin = vt.speech text: "こんにちは", speaker: "show"
  File.binwrite("/Users/flum/Desktop/test.wav", bin)
```
#### Powered by NTTアイティ
##### 漢字かな混じり文
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01
```ruby
  ctts = Mocodo::TextToSpeech::Crayon::TextToSpeech.new(api_key)
  bin = ctts.speech TextData: "こんにちは", Command: "AP_Synth", SpeakerID: 1, StyleID: 1
  File.binwrite("/Users/flum/Desktop/test.aac", bin)
```
##### SSML
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_9#tag01
```ruby
  cttss = Mocodo::TextToSpeech::Crayon::TextToSpeechSsml.new(api_key)
  bin = cttss.speech Command: "AP_Synth", SpeakerID: 1, StyleID: 1, 
    TextData: '<?xml version="1.0" encoding="utf-8" ?>
    <speak version="1.1">
    <voice name="nozomi">
    のぞみです。おはようございます。
    </voice>
    <break time="1000ms" />
    <voice name="seiji">
    せいじです。こんにちは。
    </voice>
    </speak>'
  File.binwrite("/Users/flum/Desktop/test.aac", bin)
```
##### カナアクセント文
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_8#tag01
```ruby
  ttska = Mocodo::TextToSpeech::Crayon::TextToSpeechKanaAccent.new(api_key)
  bin = ttska.speech TextData: 'エヌティーティーノ[/05]オンセーゴーセーエンジンニ[*09]ヨル[/00]オンセーデス^[.01]', Command: "AP_Synth", SpeakerID: 1, StyleID: 1
  File.binwrite("/Users/flum/Desktop/test.aac", bin)
```
  
### 画像認識
#### カテゴリ認識
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=image_recognition&p_name=category_classify#tag01
```ruby
  image_category = Mocodo::ImageRecognize::Category.new(api_key)
  puts image_category.recognize modelName: :scene, image: open("http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg")
```
#### オブジェクト認識
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=image_recognition&p_name=api_1#tag01
```ruby
  image_object = Mocodo::ImageRecognize::Object.new(api_key)
  puts image_object.recognize(open("http://i.ytimg.com/vi/kmqAuILzS14/hqdefault.jpg").read,recog: 'product-all')
```
  
### シナリオ対話
#### ユーザーID取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=scenario_dialogue&p_name=api_1#tag01
```ruby
  sr = Mocodo::ScenarioDialogue::Registration.new(api_key)
  puts sr.registration botId: :test
```
#### 対話
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=scenario_dialogue&p_name=api_2#tag01
```ruby
  sd = Mocodo::ScenarioDialogue::Dialogue.new(api_key)
  puts sd.create_dialogue botId: :test, appUserId: :test
```
  
### 発話理解
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=speech_understanding&p_name=api_1#tag01
```ruby
  t = Mocodo::SentenceUnderstanding.new(api_key)
  puts t.sentenceUnderstanding config = {
    "projectKey"=>"OSU",
    "appInfo"=>{
      "appName"=>"hoge_app",
      "appKey"=>"hoge_app01"
    },
      "clientVer"=>"1.0.0",
      "dialogMode"=>"off",
      "language"=>"ja",
      "userId"=>"12 123456 123456 0",
      "location"=>{
        "lat"=>139.766084,
        "lon"=>35.681382
    },
    "userUtterance"=>{
      "utteranceText"=>"おはようございます"
    }
  }
```
  
### トレンド記事抽出
#### ジャンル情報の取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=trend_article_extraction&p_name=api_2#tag01
```ruby
  genre = Mocodo::WebCuration::Genre.new(api_key)
  puts genre.get
```
#### 記事取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=trend_article_extraction&p_name=api_3#tag01
```ruby
  contents = Mocodo::WebCuration::Contents.new(api_key)
  puts contents.get genreId: 1
```
#### 関連記事取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=trend_article_extraction&p_name=api_9#tag01
```ruby
  related_contents = Mocodo::WebCuration::RelatedContents.new(api_key)
  puts related_contents.get contentId: 874327
```
#### キーワード検索
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=trend_article_extraction&p_name=api_4#tag01
```ruby
  search = Mocodo::WebCuration::Search.new(api_key)
  puts search.get keyword: 'パソコン'
```
  
### 言語解析
#### 形態素解析
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_1#tag01
```ruby
  morph = Mocodo::LanguageAnalysis::Morph.new(api_key)
  puts morph.analysis sentence: "日本語を分析します。", info_filter: :form
```
#### 固有表現抽出
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_2#tag01
```ruby
  entity = Mocodo::LanguageAnalysis::Entity.new(api_key)
  puts entity.extract sentence: "鈴木さんがきょうの9時30分に横浜に行きます。"
```
#### 語句類似度算出
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_3#tag01
```ruby
  similarity = Mocodo::LanguageAnalysis::Similarity.new(api_key)
  puts similarity.calculate query_pair: ["phablet", "ファブレット"]
```
#### ひらがな化
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_4#tag01
```ruby
  hiragana = Mocodo::LanguageAnalysis::Hiragana.new(api_key)
  puts hiragana.convert sentence: "漢字が混ざっている文章", output_type: :hiragana
```
#### 商品評判要約
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_6#tag01
```ruby
  shortsum = Mocodo::LanguageAnalysis::Shortsum.new(api_key)
  puts shortsum.sum length: 60, review_list: ["機能は限られていますが、必要十分でしょう。価格も安いと思います。お店の対応もよかったです。","このシリーズを買うの3台目になりました。黒の発色が綺麗です。値段を考えれば十分すぎる性能でしょう。"]
```
#### キーワード抽出
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=api_5#tag01
```ruby
  keyword = Mocodo::LanguageAnalysis::Keyword.new(api_key)
  puts keyword.extract title: "docomo Developer supportのご紹介",
    body: "株式会社NTTドコモやパートナー企業が持つ様々なアセットを「API」として汎用化して提供し、開発者へ展開することで、新たな事業の創出を推進する協創プラットフォームです。",
    max_num: 3, focus: :ORG
```
#### カテゴリ分析
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=jetrun_api_1#tag01
```ruby
  clusteranalytics = Mocodo::LanguageAnalysis::Truetext::Clusteranalytics.new(api_key)
  puts clusteranalytics.analysis text: "昨日は隅田川花火大会を見に行ってきました。
  地下鉄の浅草駅で降りた瞬間から、大混雑していました。
  地上に出てみると人混みと交通規制の多さで大苦戦しましたが、
  何とか良い場所で花火を見るこが出来ました。
  夏の風物詩、花火をどうぞお楽しみください"
```
#### センシティブ分析
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=language_analysis&p_name=jetrun_api_2#tag01
```ruby
  sensitivecheck = Mocodo::LanguageAnalysis::Truetext::Sensitivecheck.new(api_key)
  puts sensitivecheck.analysis text: "３Ｄプリンタで銃の設計図を期間限定公開中、脱法ハーブはこちら"
```
  
### 山座同定
#### 名前及び稜線データ取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=mountain_identification&p_name=api_1#tag01
```ruby
  rendering = Mocodo::MountainIdentification::RidgeRendering.new(api_key)
  puts rendering.rendering lat: 35.62512, lon: 139.243658, azimuth: 230.0, altura: 1.0, angleOfView: 45.0
```
#### 補正データ取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=mountain_identification&p_name=api_2#tag01
```ruby
  matching = Mocodo::MountainIdentification::RidgeMatching.new(api_key)
  puts matching.get image: open("http://pod.cheerup.jp/files/images/1674/A.jpg").read,
    ridge: [214,214,214,213,213,213,213,213,214,214,214,215,215,214,214,213,213,213,212,212,212,212,212,212,212,213,213,214,214,214,214,214,214,214,214,214,214,214,214,214,215,214,214,214,214,214,214,213,213,213,212,212,212,211,211,211,211,211,211,211,211,211,211,211,212,212,212,212,213,213,213,213,214,214,214,214,215,215,215,216,216,216,217,217,218,218,218,218,219,219,219,219,219,219,219,219,219,219,219,219,219,219,218,218,218,218,219,219,218,218,218,218,218,218,218,218,218,218,218,218,218,217,217,218,218,218,218,218,218,218,218,218,218,218,217,217,218,217,217,217,217,217,216,216,216,216,216,216,216,216,216,216,216,215,216,216,217,217,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,217,217,217,217,217,217,217,218,218,218,218,218,219,219,220,220,220,220,221,221,221,221,221,221,221,221,222,222,223,223,223,223,223,223,223,224,224,224,225,225,225,226,226,227,227,227,227,228,228,228,229,229,230,230,230,230,230,229,229,229,229,229,229,229,229,229,229,229,230,230,231,231,232,232,232,233,233,232,232,232,231,231,231,232,232,232,232,233,233,233,233,233,234,234,233,233,232,232,232,232,231,231,231,231,231,231,231,231,231,230,230,230,230,230,230,229,229,229,229,229,230,230,230,230,229,229,229,228,228,228,228,228,227,227,227,226,226,226,226,225,225,224,224,224,224,224,224,223,223,223,223,222,222,221,221,220,220,220,219,219,219,219,219,219,219,220,220,220,221,221,221,222,222,222,223,223,223,224,224,224,225,225,226,226,226,225,225,225,226,226,226,226,225,225,224,225,225,225,225,226,226,225,226,226,226,226,227,227,227,226,226,225,225,225,225,225,225,225,225,225,224,224,224,223,223,223,222,222,222,221,220,220,220,219,219,219,218,218,218,217,217,216,216,216,215,215,215,215,215,215,215,215,214,215,215,215,214,214,215,215,216,216,216,217,217,218,218,218,219,220,220,221,221,221,222,222,223,223,223,224,224,224,225,225,225,226,226,226,227,227,227,227,228,228,228,229,229,228,228,228,228,228,228,228,228,228,228,228,228,229,229,230,230,230,230,230,230,230,229,229,230,230,230,230,230,230,229,229,229,229,229,229,229,230,230,230,229,229,228,228,228,228,228,228,228,228,228,228,229,229,229,229,229,229,229,228,228,228,228,227,228,228,228,229,229,229,229,229,230,230,230,230,230,230,230,230,230,230,230,231,231,231,231,231,230,230,231,231,231,232,232,232,233,233,233,233,233,233,233,233,234,234,234,234,235,235,235,236,236,236,236,236,235,236,236,236,236,236,236,236,236,235,235,235,235,235,235,235,235,235,235,235,236,236,236,236,237,237,237,237,238,238,238,239,239,239,239,239,239,239,239,239,239,238,239,239,239,240,240,239,239,240,239,239,239,239],
    ridgeWidth: 640, ridgeHeight: 480
```
#### 名前、稜線データ及び補正データ取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=mountain_identification&p_name=api_3#tag01
```ruby
  recognition = Mocodo::MountainIdentification::RidgeRecognition.new(api_key)
  puts recognition.get image: open("https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/FujiSunriseKawaguchiko2025WP.jpg/275px-FujiSunriseKawaguchiko2025WP.jpg").read,
    lat: 35.62512, lon: 139.243658, azimuth: 230.0, altura: 1.0, angleOfView: 45.0
```
    
### 文字認識
#### 情景画像認識要求
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_1#tag01
```ruby
  scene = Mocodo::CharacterRecognition::Scene.new(api_key)
  scene.request image: open("http://kwout.com/cutout/h/3t/v3/6t9_bor_rou.jpg").read
```
#### 情景画像認識結果取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_2#tag01
```ruby
  scene.result
```
#### 情景画像認識取消
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_3#tag01
```ruby
  scene.cancel
```
#### 行画像認識要求
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_4#tag01
```ruby
  line = Mocodo::CharacterRecognition::Line.new(api_key)
  puts line.request image: open("http://corobuzz.com/wp-content/uploads/2014/10/kb.jpg").read
```
#### 文章画像認識要求
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_5#tag01
```ruby
  document = Mocodo::CharacterRecognition::Document.new(api_key)
  puts document.request image: open("http://corobuzz.com/wp-content/uploads/2014/10/kb.jpg").read
```
#### 文章画像認識結果取得
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_6#tag01
```ruby
  document.result
```
#### 文章画像認識取消
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_7#tag01
```ruby
  document.cancel
```
#### 文章画像レイアウト認識要求
https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=character_recognition&p_name=api_8#tag01
```ruby
  layout = Mocodo::CharacterRecognition::Layout.new(api_key)
  puts layout.request image: open("http://corobuzz.com/wp-content/uploads/2014/10/kb.jpg").read
```

##Supported APIs
>雑談対話

>知識Q&A

>音声合成  

>>Powered by エーアイ  

>>>SSML  

>>>中間言語(AIカナ)

>>>JEITAカナ

>>Powered by HOYAサービス

>>>音声合成

>>Powered by NTTアイティ

>>>漢字かな混じり文

>>>SSML

>>>カナアクセント文

>>画像認識

>>>カテゴリ認識

>>>オブジェクト認識

>>シナリオ対話

>>>ユーザーID取得

>>>対話

>>発話理解

>>トレンド記事抽出

>>>ジャンル情報の取得

>>>記事取得

>>>関連記事取得

>>>キーワード検索

>>言語解析

>>>形態素解析

>>>固有表現抽出

>>>語句類似度算出

>>>ひらがな化

>>>商品評判要約

>>>キーワード抽出

>>>カテゴリ分析

>>>センシティブ分析

>>山座同定

>>>名前及び稜線データ取得

>>>補正データ取得

>>>名前、稜線データ及び補正データ取得

>>文字認識

>>>情景画像認識要求

>>>情景画像認識結果取得

>>>情景画像認識取消

>>>行画像認識要求

>>>文章画像認識要求

>>>文章画像認識結果取得

>>>文章画像認識取消

>>>文章画像レイアウト認識要求

##License

The MIT License

-------
(c) @2015 flum_