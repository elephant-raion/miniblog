# 誰でもユーザーアカウントを登録できる。ただし、ログインにはユーザー名を用いる

## タスクばらし

- [x] 大まかなタスクにばらす, 見積時間: 30 min., 所要時間: 25 min.
- [x] [`devise` gemの設定をする]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [User modelを作成する]タスクをばらす, 見積時間: 10 min., 所要時間: 10 min.
- [x] [User modelの属性のvalidationを定める]タスクをばらす, 見積時間: 5 min., 所要時間: 7 min.
- [x] [ログインにユーザー名を用いる]タスクをばらす, 見積時間: 30 min., 所要時間: 28 min.
- [x] [User model用のDevise controllerを生成し、整備する]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [User model用のviewを生成し、整備する]タスクをばらす, 見積時間: 20 min., 所要時間: 15 min.
- [x] [ユーザーアカウントを登録するsystem specを作成する]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [ユーザーがログインしてログアウトするsystem specを作成する]タスクをばらす, 見積時間: 10 min., 所要時間: 5 min.

## 調査

- [x] Deviseで独自のcontrollerを使うときの設定を調べる, 見積時間: 15 min., 所要時間: 12 min.
- [x] URLのvalidationの方法を調べる, 見積時間: 20 min., 所要時間: 15 min.
- [x] ログイン情報としてユーザー名を使う方法を調べる, 見積時間: 30 min., 所要時間: 30 min.
- [x] 認証キーを`User#name`に変更するときに、`self.find_for_database_authentication(conditions)`をoverrideする必要があるか調べる, 見積時間: 10 min., 所要時間: 5 min.

## 実装

- [x] `devise` gemの設定をする, 見積時間: 10 min., 所要時間: 9 min.
  - `rails g devise:install`
  - devise initializerを編集して、viewの検索ではscopeを優先するように設定する
    `config.scoped_views = true`
  - 開発及び本番の両環境のActionMailerのurlを設定する
- [x] User modelを作成する, 見積時間: 10 min., 所要時間: 4 min.
  - `rails g devise User name:string profile:text url:string`
  - `name`はユーザー名、`profile`はプロフィール、`url`はブログURLを記録する属性である
  - `name`にunique indexを付与する
    - `add_index :users, :name, unique: true`
  - それら属性は`null`となることを許さず、defaultで空文字である
    - `null: false, default: ''`
- [x] User modelの属性のvalidationを定める, 見積時間: 15 min., 所要時間: 4 min.
  - URLのvalidationに`validate_url` gemを用いる
  ```ruby
  validates :name, presence: true, uniqueness: true, length: { maximum: 20}, format: { with: /\A[a-zA-Z]+\Z/ }
  validates :profile, length: { maximum: 200 }
  validates :url, url: { allow_blank: true }
  ```
- [x] User modelのmodel specを作成する, 見積時間: 30 min., 所要時間: 28 min.
  - User modelのfactoryを作成する
  - 全てのvalidationが想定通り動いていることを確かめるmodel specを作成する
- [x] ログインにユーザー名を用いる, 見積時間: 3 min., 所要時間: 3 min.
  ```ruby
  # models/user.rb

  devise authentication_keys: [:name]

  def self.find_for_database_authentication(conditions)
    where(conditions).first
  end
  ```
- [x] User model用のDevise controllerを生成し、整備する, 見積時間: 5 min., 所要時間: 2 min.
  - `rails g devise:controllers users`
  - 不要なcontrollerを削除する
  - 不要なコメントを削除する
- [x] registration_controller.rbを編集して、ユーザーアカウントの作成時にEメール、プロフィール、ブログURLを記入できる状態にする, 見積時間: 5 min., 所要時間: 4 min.
  ```ruby
  # registrations_controller.rb

  before_action :configure_sign_up_params, only: :create

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email profile url])
  end
  ```
- [x] ユーザーアカウント登録のroutingを独自のcontrollerを使う設定にする, 見積時間: 3 min., 所要時間: 2 min.
  ```ruby
  devise_for :user, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  ```
- [x] User model用のviewを生成し、整備する, 見積時間: 20 min., 所要時間: 10 min.
  - `devise-i18n` gemを使って、`devise` gemのlocaleを利用できるようにする
  - `rails g devise:i18n:views users`
  - `HAML_RAILS_DELETE_ERB=true rails haml:erb2haml`
  - 不要なものを削除する
- [x] ユーザーアカウント登録に関するviewを整備する, 見積時間: 15 min., 所要時間: 4 min.
  - ユーザー名、プロフィール、ブログURLを入力できるようにする。ただし、ユーザー名は必須入力とする
- [x] User modelとそのDevise controller用のlocale fileを生成し、整備する, 見積時間: 15 min., 所要時間: 3 min.
  - `rails g devise:i18n:locale ja`
- [x] User modelのlocaleにユーザー名、プロフィール、ブログURLの定義をする, 見積時間: 5 min., 所要時間: 2 min.
- [x] ログイン前とログイン後のnavigation barを作成する, 見積時間: 20 min., 所要時間: 18 min.
- [x] ログイン画面を作成する, 見積時間: 15 min., 所要時間: 6 min.
- [x] simple_formのlocale fileを整える, 見積時間: 5 min., 所要時間: 2 min.
- [x] ユーザーアカウントを登録するsystem specを作成する, 見積時間: 30 min., 所要時間: 14 min.
  - 以下の流れができることを検証する
    1. トップページにアクセスする
    2. アカウント登録リンクをクリックし、登録画面を表示する
    3. 全ての項目を入力する
    4. 登録するボタンを押す。押す前と後で、ユーザーアカウント全体の総数が1増えることを確かめる
    5. 登録成功のメッセージが表示することを確かめる
  - 上記の３で、数字が入ったユーザー名を入力しvalidation errorが表示されることを確かめる
- [x] ユーザーがログインしてログアウトするsystem specを作成する, 見積時間: 20 min., 所要時間: 18 min.
  - 以下の流れができることを検証する
    1. トップページにアクセスする
    2. ログインリンクをクリックし、ログイン画面を表示する
    3. ユーザー名とパスワードを入力する
    4. ログインボタンを押す。
    5. ログインが成功したことを表すメッセージが表示されることを確かめる
  - 上記の3で間違ったパスワードを入力し、error messageが表示されることを確かめる
