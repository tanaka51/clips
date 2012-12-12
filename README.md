Clips
=====

Github オーガナイゼーションのグループ間で、コード片を共有する事ができます。

Gist はとても便利ですが、URL がオープンな事が欠点とも言えます。
気軽に外に出せないコードを Clips で共有しましょう！ Let's do clip!!!


https://doclip.herokuapp.com/


## 特徴
* Github でサインインすると、所属しているオーガナイゼーションのグループが自動的に作成されます
* 投稿したクリップは Ruby でシンタックスハイライトされます

## 必要なこと
* Github のアカウントを持っていること
* 一つ以上のオーガナイゼーションに属していること

## TODO
* シンタックスハイライトの種類を増やす
* コメント機能
* いいね機能 or(and) お気に入り機能
* デザインをかっこよく

## 開発
* git glone
* cp database.yml.sample database.yml
* bundle install
* rake db:migrate
* rake db:test:prepare
* rspec spec/
* rails server
