# 開発、テスト、本番の全環境を開発しやすい状態にする

## タスクばらし

- [x] 大まかなタスクにばらす, 見積時間: 30 min., 所要時間: 21 min.
- [x] [generatorにより余計なfileが生成されないようにする]タスクをばらす, 見積時間: 15 min., 所要時間: 2 min.
- [x] [DBの環境を整える]タスクをばらす, 見積時間: 15 min., 所要時間: 20 min.
- [x] [Template engineをhamlに変更する]タスクをばらす, 見積時間: 5 min., 所要時間: 4 min.
- [x] [Static assetをwebpackerで管理する]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [Bootstrapを導入する]タスクをばらす, 見積時間: 5 min., 所要時間: 4 min.
- [x] [Test環境を整える]タスクをばらす, 見積時間: 30 min., 所要時間: 35 min.
- [x] [Lintを導入する]タスクをばらす, 見積時間: 15 min., 所要時間: 24 min.
- [x] [Lintを導入する]タスクをばらし直す, 見積時間: 30 min., 所要時間: 28 min.
- [x] [日本語化する]タスクをばらす, 見積時間: 10 min., 所要時間: 8 min.
- [x] [simple_form gemを導入する]タスクをばらす, 見積時間: 15 min., 所要時間:  2 min.
- [x] [Herokuに本番環境を作る]タスクをばらす, 見積時間: 10 min., 所要時間: 5 min.

## 調査

- [x] railsのgeneratorの設定方法を調べる, 見積時間: 30 min., 所要時間: 5 min.
- [x] railsでpostgresqlを使う方法を調べる, 見積時間: 5 min., 所要時間: 3 min.
- [x] Template engineをhamlにする方法を調べる, 見積時間: 5 min., 所要時間: 3 min.
- [x] rails_best_practices gemの使い方を調べる, 見積時間: 10 min., 所要時間: 15 min.
- [x] brakeman gemの使い方を調べる, 見積時間: 15 min., 所要時間: 13 min.
- [x] overcommit gemの使い方を調べる, 見積時間: 20 min., 所要時間: 25 min.
- [x] simplecov gemの使い方を調べる, 見積時間: 15 min., 所要時間: 12 min.

## 実装

- [x] Projectを作成する, 見積時間: 5 min., 所要時間: 5 min.
  `rails new miniblog -d postgresql --skip-test-unit --skip-test`
  - 上記で作成したprojectのremote repositoryを設定する
    - GitHubでminiblogという名前のrepositoryを作成する
    - GitHub上の手順に従って、miniblog repositoryを上記projectのremote repositoryとする
- [x] 不要なgemを取り除く, 見積時間: 3 min., 所要時間: 1 min.
  - `jbuilder` gemを`Gemfile`から取り除く
- [x] generatorにより余計なfileが生成されないようにする, 見積時間: 3 min., 所要時間: 3 min.
  - `config/application.rb`に、以下を加える
  ```ruby
  config.generators do |g|
    g.assets false
    g.helper false
  end
  ```
- [x] DBの環境を整える, 見積時間: 30 min., 所要時間: 7 min.
  - `config/database.yml`に以下を加える
  ```yml
  default: &default
    username: miniblog
    password: 
    host: localhost
  ```
  - `config/database.yml`から`production`のところを削除する
  - PostgreSQL DBに、`miniblog`という名前のユーザを作成する
    `createuser miniblog`
  - 開発とテストの両方のDBを作成する
  ```
  createdb miniblog_development -O miniblog
  createdb miniblog_test -O miniblog
  ```
  - `config/database.yml`をコピーして、`config/database.yml.sample`を作る
  - `config/database.yml`をGitの管理外にする
    - `.gitignore`に、`/config/database.yml`を加える
  - `rails s`を実行して、DBにアクセスできていることを確かめる
- [x] Template engineをhamlに変更する, 見積時間: 5 min., 所要時間: 4 min.
  - `haml-rails, ~> 2.0` gemを`Gemfile`に加えて、`bundle install`する
  - `rails haml:erb2haml`を実行して、erb fileをhaml fileに変換する
- [x] Static assetをwebpackerで管理する, 見積時間: 10 min., 所要時間: 3 min.
  - `app/assets/stylesheets/application.css`を削除する
  - `app/javascript`に`stylesheets`, `images` directoryを作成する
  - `stylesheets` directoryに、`application.scss`を作成する
  - `app/javascript/packs/application.js`に、以下を加える
    `import '../stylesheets/application.scss'`
- [x] Bootstrapを導入する, 見積時間: 5 min., 所要時間: 5 min.
  - Bootstrap5をinstallする
    `yarn add bootstrap @popperjs/core`
  - `app/javascript/stylesheets/application.scss`に、以下を加える
    `@import '~bootstrap/scss/bootstrap.scss'`
  - `app/javascript/packs/application.js`に、以下を加える
    ```js
    import 'bootstrap'
    import '@popperjs/core'
    ```
  - `app/views/layouts/application.html.haml`の`stylesheet_link_tag`を`stylesheet_pack_tag`に置き換える
- [x] Test環境を整える, 見積時間: 10 min., 所要時間: 8 min.
  - `rspec-rails`, `factory_bot_rails` gemを`Gemfile`に加え、`bundle install`する。ただし、groupは、`:development, :test`である
  - `rails g rspec:install`を実行する
  - `.rspec`に、`--format documentation`を追加する
  - `config/application.rb`に、以下を加える。
  ```ruby
  config.generators do |g|
    g.test_framework :rspec, view_specs: false, helper_specs: false, routing_specs: false, request_specs: false
  end
  ```
  - `spec/support` directory直下のfileを読み込むようにする。
  - `FactoryBot`のメソッドを`FactoryBot`をつけないで呼び出せるようにする。`spec/support/config/factory_bot.rb`に以下を書き込む。
  ```ruby
  require 'factory_bot'

  RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
  end
  ```
  - System specのdriverをcommad-lineにoptionにより、変更できるようにする。`spec/support/config/capybara.rb`に以下を書き込む。
  ```ruby
  require 'capybara/rspec'

  RSpec.configure do |config|
    config.before(:each, type: :system) do
      driven_by :rack_test
    end

    config.before(:each, type: :system, js: true) do
      if ENV['NO_HEADLESS'].present?
        driven_by :selenium_chrome
      else
        driven_by :selenium_chrome_headless
      end
    end
  end
  ```
- [x] VSCodeの`settings.json`に以下の設定をする,見積時間: 10 min., 所要時間: 6 min. 
  ```yml
  "editor.suggestSelection": "first",
  "editor.renderWhiteSpace": "all",
  "editor.suggest.preview": true,
  "editor.suggest.shareSuggestSelections": true,
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": false
  },
  "editor.formatOnSave": true
  ```
- [x] rubocop gemを導入する, 見積時間: 3 min., 所要時間: 2 min.
  - `gem 'rubocop', require: false, group: :development` >> `Gemfile`
  - `"ruby.rubocop.useBundler": true` >> `settings.json`
- [x] haml-lint gemを導入する, 見積時間: 3 min., 所要時間: 2 min.
  - `gem 'haml-lint', require: false, group: :development` >> `Gemfile`
  - `"hamlLint.useBundler": true` >> `settings.json`
- [x] rubocopとhaml-lintの設定をする, 見積時間: 10 min., 所要時間: 8 min.
  - `gem 'sgcop', github: 'SonicGarden/sgcop', require: false, group: :development` >> `Gemfile`
  - `.rubocop.yml`を作成する。中身は以下。
    ```yml
    inherit_gem:
      sgcop: rails/rubocop.yml
    ```
  - `.haml-lint.yml`を作成する。中身は`sgcop` gemのrepositoryの`haml/haml-lint.yml`からコピー。
  - rubocopとhaml-lintをそれぞれ実行し、指摘されたことに対して対処する
- [x] solargraph gemを導入する, 見積時間: 3 min., 所要時間: 2 min.
  - `gem 'solargraph', require: false, group: :development` >> `Gemfile`
  - `"solargraph.useBundler": true` >> `settings.json`
- [x] rails_best_practices gemを導入する, 見積時間: 2 min., 所要時間: 2 min.
  - `gem 'rails_best_practices', require: false, group: :development` >> `Gemfile`
- [x] brakeman gemを導入する, 見積時間: 2 min., 所要時間: 2 min.
  - `gem 'brakeman', require: false, group: :development` >> `Gemfile`
- [x] overcommit gemを導入する, 見積時間: 10 min., 所要時間: 3 min.
  - `gem 'overcommit', require: false, group: :development` >> `Gemfile`
  - `bundle exec overcommit --install`で`.overcommit.yml`を作成する
  - `.overcommit.yml`に以下を追加する。
    ```yml
    CommitMsg:
      ALL:
        enabled: false
    PreCommit:
      AuthorEmail:
        enabled: false
      AuthorName:
        enabled: false
      BrokenSymlinks:
        enabled: false
      CaseConflicts:
        enabled: false
      HamlLint:
        enabled: true
        command: ['bundle', 'exec', 'haml-lint', 'app/views']
      MergeConflicts:
        enabled: false
      RuboCop:
        enabled: true
        command: ['bundle', 'exec', 'rubocop']
      RailsBestPractices:
        enabled: true
        command: ['bundle', 'exec', 'rails_best_practices']
    PrePush:
      Brakeman:
        enabled: true
        command: ['bundle', 'exec', 'brakeman']
      RSpec:
        enabled: true
        command: ['bundle', 'exec', 'rspec']
    ```
  - `bundle exec overcommit --sign`により、上記設定を反映させる
- [x] simplecov gemを導入する, 見積時間: 5 min., 所要時間: 5 min.
  - `gem 'simplecov', require: false, group: :test` >> `Gemfile`
  - `spec/spec_helper.rb`の下部に、以下を追加する。
    ```ruby
    require 'simplecov'
    SimpleCov.start 'rails'
    ```
- [x] 日本語化する, 見積時間: 5 min., 所要時間: 3 min.
  - rails-i18n gemのreopositoryの`rails/locale/ja.yml`を`config/locales`にコピーする
  - `config/application.rb`に以下を追加する
    ```ruby
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    ```
- [x] simple_form gemを導入する, 見積時間: 5 min., 所要時間: 5 min.
  - `gem 'simple_form'` >> `Gemfile`
  - `rails g simple_form:install --bootstrap`
- [x] Herokuに本番環境を作る, 見積時間: 10 min., 所要時間: 20 min.
  - `heroku create`
  - `git push heroku main`
  - `heroku run rake db:migrate`
  - 自動的にdeployされるようにする
