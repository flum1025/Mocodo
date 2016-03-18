# Mocodo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mocodo`. To experiment with that code, run `bin/console` for an interactive prompt.

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

requireしてから

```
dialogue = Mocodo::Dialogue.new(api_key)  
puts dialogue.create_dialogue "こんにちは"  
```

たったこれだけで会話することができます。   
詳しいパラメータ等は、ガイドラインを参照して  
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
※印の付いたAPIは現在エラーが発生して使用できません。  
ソースを見てわかる人は修正お願いします。  

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mocodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
