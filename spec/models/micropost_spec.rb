require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe '投稿内容が' do
    context '文字数が140以下である場合' do
      let(:micropost) { build :micropost, content: 'A short message' }

      it 'その文字数は適切である' do
        expect(micropost).to be_valid
      end
    end

    context '文字数が141以上である場合' do
      let(:micropost) { build :micropost, content: 'a' * 141 }

      it 'その文字数は長すぎる' do
        expect(micropost).to be_invalid
        expect(micropost.errors).to be_of_kind(:content, :too_long)
      end
    end

    context '空である場合' do
      let(:micropost) { build :micropost, content: '' }

      it 'モデルの状態として不適切である' do
        expect(micropost).to be_invalid
        expect(micropost.errors).to be_of_kind(:content, :blank)
      end
    end
  end

  describe '投稿時間が' do
    context 'nilである場合' do
      let(:micropost) { build :micropost, posted_at: nil }

      it 'モデルの状態として不適切である' do
        expect(micropost).to be_invalid
        expect(micropost.errors).to be_of_kind(:posted_at, :blank)
      end
    end
  end
end
