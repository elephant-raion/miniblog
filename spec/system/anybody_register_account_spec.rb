require 'rails_helper'

RSpec.describe '誰でもアカウントを登録できる', type: :system do
  context '全てを適切に入力した場合' do
    it 'アカウントが登録される', js: true do
      visit root_path
      click_link 'アカウント登録'
      fill_in 'ユーザー名', with: 'tester'
      fill_in 'Eメール', with: 'tester@example.com'
      fill_in 'プロフィール', with: 'I am a tester'
      fill_in 'ブログURL', with: 'https://github.com/tester'
      fill_in 'パスワード *', with: 'password'
      fill_in 'パスワード（確認用） *', with: 'password'

      expect { click_button 'アカウント登録' }.to change(User, :count).by(1)
      expect(page).to have_current_path root_path
      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end

  context '数字入りのユーザー名を入力した場合' do
    it 'アカウントを登録できない', js: true do
      visit root_path
      click_link 'アカウント登録'
      fill_in 'ユーザー名', with: 'tester1'
      fill_in 'Eメール', with: 'tester@example.com'
      fill_in 'プロフィール', with: 'I am a tester'
      fill_in 'ブログURL', with: 'https://github.com/tester'
      fill_in 'パスワード *', with: 'password'
      fill_in 'パスワード（確認用） *', with: 'password'

      expect { click_button 'アカウント登録' }.not_to change(User, :count)
      expect(page).to have_content 'ユーザー名は不正な値です'
    end
  end
end
