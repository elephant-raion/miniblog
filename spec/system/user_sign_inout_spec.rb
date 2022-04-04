require 'rails_helper'

RSpec.describe 'ユーザーはログインとログアウトができる', type: :system do
  context 'ユーザー名とパスワードを適切に入力した場合' do
    before do
      create :user, name: 'tester', password: 'password'
    end

    it 'ログインでき、その後、ログアウトできる', js: true do
      visit root_path
      click_link 'ログイン'
      fill_in 'ユーザー名', with: 'tester'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_current_path root_path
      expect(page).to have_content 'ログインしました。'

      click_link 'ログアウト'
      expect(page).to have_current_path root_path
      expect(page).to have_content 'ログアウトしました。'
    end
  end

  context '間違ったパスワードを入力した場合' do
    before do
      create :user, name: 'tester', password: 'password'
    end

    it 'ログインできない', js: true do
      visit root_path
      click_link 'ログイン'
      fill_in 'ユーザー名', with: 'tester'
      fill_in 'パスワード', with: 'password123'
      click_button 'ログイン'

      expect(page).to have_content 'ユーザー名またはパスワードが違います。'
    end
  end
end
