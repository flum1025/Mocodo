Mocodo
===========

##What is it?

rubyで書かれたdocomoAPIのクライアントライブラリです。
apiについての説明は[API共通ガイドライン](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=image_recognition&p_name=api_usage_scenario)へ  
公式サイトは[docomo Developer support](https://dev.smt.docomo.ne.jp/)  

動作確認はubuntu14.04 ruby1.9.3とOS X Yosemite ruby2.0.0です。

##How to Use
まず、公式サイトからAPIキーを取得してください。  
会話する場合はrequireしてから

```
dialogue = Mocodo::Dialogue.new(api_key)  
puts dialogue.create_dialogue "こんにちは"  
```

たったこれだけで会話することができます。   
詳しいパラメータ等は、さらすてぃ姉妹のサイトを参照して  
```
dialogue.configure config = {  
:mode=>"dialog",  
}  
```
の様な感じでセットしてください。

##Supported APIs
>画像認識  

>発話理解  

>音声合成  

>>漢字かな混じり文  

>>SSML  

>>カナアクセント文  

>※文字認識  

>>情景画像認識要求  

>>情景画像認識結果取得  

>>情景画像認識取消  

>>行画像認識要求  

>>文章画像認識要求  

>>文章画像認識結果取得  

>>文章画像認識取消  

>>文章画像レイアウト認識要求  

>言語解析  

>>形態素解析  

>>固定表現抽出  

>>語句類似度算出  

>>ひらがな化  

>雑談対話  

>トレンド記事抽出  

>>ジャンル情報の取得  

>>記事取得  

>>キーワード検索  

>知識Q&A  

##Notice
エラーが発生した場合はMocodoErrorをraiseします。  
※印の付いたAPIは現在エラーが発生して使用できません。  
ソースを見てわかる人は修正おねがいします。  
/mocodo/mocodo.rbをrequireすることですべてのライブラリを呼び出すことができますが、  
最小限だけにとどめたい場合は/mocodo/lib/の中から必要なものだけrequireしてください。  
その場合、client.rbは必須なので必ずrequireしてください。  
mocodo-example.rbは使用例ですので、参考にしてみてください。  


質問等ありましたらTwitter:[@flum_](https://twitter.com/flum_)までお願いします。

##License

The MIT License

-------
(c) @2015 flum_