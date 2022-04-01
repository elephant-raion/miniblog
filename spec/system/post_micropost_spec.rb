require 'rails_helper'

RSpec.describe '短文を投稿できる', type: :system do
  context '短文を入力した場合' do
    it '投稿に成功する', js: true do
      visit root_path
      fill_in '投稿内容', with: 'A short message'

      expect { click_button '投稿する' }.to change { Micropost.all.count }.from(0).to(1)
      expect(page).to have_current_path microposts_path
      expect(page).to have_content '投稿に成功しました'
      expect(page).to have_content 'A short message'
      expect(page).to have_content '投稿時間'
    end
  end

  context '長文を入力した場合' do
    it '投稿に失敗する', js: true do
      visit root_path
      fill_in '投稿内容', with: 'a' * 200

      expect { click_button '投稿する' }.not_to change(Micropost, :count)
      expect(page).to have_current_path microposts_path
      expect(page).to have_content '投稿に失敗しました'
    end
  end
end
