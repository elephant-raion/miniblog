# 短文を投稿できる

## タスクばらし

- [x] 大まかなタスクにばらす, 見積時間: 20 min., 所要時間: 15 min.
- [x] [Micropostのviewを追加する]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [[短文を投稿する]というユースケースが実現可能であることを確かめるsystem specを追加する]タスクをばらす, 見積時間: 20 min., 所要時間: 18 min.
- [x] [Paginationを`kaminari` gemで実現する]タスクをばらす, 見積時間: 30 min., 所要時間: 30 min.

## 調査

- [x] Bootstrapのgrid systemをどのように振る舞うのかを調べる, 見積時間: 30 min., 所要時間: 40 min.
- [x] simple_formのsubmitで表示されるラベルをロケールファイルから探し出す方法を調べる, 見積時間: 15 min., 所要時間: 13 min.
- [x] `kaminari` gemの使い方を調べる, 見積時間: 15 min., 所要時間: 13 min.

## 実装

- [x] Micropost modelを追加する, 見積時間: 15 min., 所要時間: 5 min.
  - このモデルのattributesは以下である
    - 投稿内容: `content:text, null: false`
    - 投稿日時: `posted_at:datetime, null: false`
  - 上記attributesは、それぞれ以下のvalidationを持つ
    - 投稿内容: `presence: true, length: { maximum: 140 }`
    - 投稿日時: `presence: true`
- [x] Micropostのmodel specを追加する, 見積時間: 10 min., 所要時間: 20 min.
  - Micropost modelのvalidationが想定通り動いているかを検証する
- [x] Micropost controllerを追加する, 見積時間: 10 min., 所要時間: 13 min.
  - 以下のactionを追加する
    - `index`: 全ての投稿を表示するためのもの。投稿フォームを表示するためのもの。
    - `create`: 短文を投稿するためのもの。
- [x] Micropostのviewを追加する, 見積時間: 30 min., 所要時間: 60 min.
  - `index.html.haml`を追加する
    - 投稿フォームと、全ての投稿を表示するためのもの。
    - 上部にnavigation barがある。左端に[ミニブログ]と表示されている
    - 投稿の成功・失敗をflash_messageで表示する
    - 左側に投稿フォーム、右側に全ての投稿が表示される。simple_form gemを用いる。
    - 投稿は、投稿内容と投稿日時で構成される。`card` classで表現する。
    - 全ての投稿は、`pagy` gemを用いてpagingする。
    - 投稿時間は、次のフォーマットで表示する
      - YYYY/MM/DD hh:mm
      - `l micropost.posted_at, format: :long`
      - `Micropost.human_attribute_name(:posted_at)`
- [x] [短文を投稿する]というユースケースが実現可能であることを、確かめるsystem specを追加する, 見積時間: 15 min., 所要時間: 25 min.
  - 以下の流れができることを検証する。
    1. トップページにアクセスする。
    2. 投稿フォームに`A short message`と入力する
    3. [投稿する]ボタンを押す。押す前と後で、投稿全体の総数が１増えることを確かめる。
    4. トップページにリダイレクトされていることを確かめる
    5. そこに、`A short messge`という投稿が表示されていることを確認する
    6. さらに、投稿日時が表示されていることも確かめる
  - 文字数が多すぎて、失敗するパターンも検証する
- Paginationを`kaminari` gemで実現する
  - [x] `pagy` gemに関連するものを取り除く, 見積時間: 10 min., 所要時間: 4 min.
    - `Gemfile`から`pagy` gemを取り除く
    - `config/initializers/pagy.rb`を削除する
    - `app/helpers/application_helper.rb`から`include Pagy::Frontend`を消す
    - `app/controllers/application_controller.rb`から`include Pagy::Backend`を消す
  - [x] `kaminari` gemを導入する, 見積時間: 5 min., 所要時間: 3 min.
    -  `gem 'kaminari'` >> `Gemfile`
    -  1 pageごとに10投稿だけ表示する
       - `rails g kaminari:config`
       - `config/initializers/kaminari_config.rb`に`config.default_per_page = 10`と設定する
  - [x] pagination のlayoutをbootstrap5仕様にする, 見積時間: 30 min., 所要時間: 30 min.
    - `rails g kaminari:views default`
  - [x] controllerとviewを`kaminari` gem仕様にする, 見積時間: 3 min., 所要時間: 2 min.
    - controller
      - `@microposts = Micropost.order(id: :desc).page params[:page]`
    - view
      - `= paginate @microposts`
  - [x] `kaminari` gem用のlocale file `config/locales/kaminari.ja.yml`を設定する, 見積時間: 15 min., 所要時間: 10 min.

  