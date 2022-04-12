require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー名が' do
    context '空である場合' do
      let(:user) { build :user, name: '' }

      it 'モデルとして不適切である' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:name, :blank)
      end
    end

    context '既に利用されている場合' do
      let(:user) { build :user, name: 'tester' }

      before do
        create :user, name: 'tester'
      end

      it 'そのユーザー名は利用できない' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:name, :taken)
      end
    end

    context '20文字である場合' do
      let(:user) { build :user, name: 'a' * 20 }

      it 'その長さは適切である' do
        expect(user).to be_valid
      end
    end

    context '21文字である場合' do
      let(:user) { build :user, name: 'a' * 21 }

      it 'その長さは不適切である' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:name, :too_long)
      end
    end

    context 'アルファベットだけで構成される場合' do
      let(:user) { build :user, name: 'tester' }

      it 'それは適切な形式である' do
        expect(user).to be_valid
      end
    end

    context '数字が含まれている場合' do
      let(:user) { build :user, name: 'tester1' }

      it 'それは不適切な形式である' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:name, :invalid)
      end
    end
  end

  describe 'プロフィールが' do
    context '200文字である場合' do
      let(:user) { build :user, profile: 'a' * 200 }

      it 'その長さは適切である' do
        expect(user).to be_valid
      end
    end

    context '201文字である場合' do
      let(:user) { build :user, profile: 'a' * 201 }

      it 'その長さは不適切である' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:profile, :too_long)
      end
    end
  end

  describe 'ブログURLが' do
    context 'スキームを持たない場合' do
      let(:user) { build :user, blog_url: 'github.com/tester' }

      it 'それは不適切である' do
        expect(user).to be_invalid
        expect(user.errors).to be_of_kind(:blog_url, :url)
      end
    end

    context 'スキームを持つ場合' do
      let(:user) { build :user, blog_url: 'https://github.com/tester' }

      it 'それは適切である' do
        expect(user).to be_valid
      end
    end
  end
end
