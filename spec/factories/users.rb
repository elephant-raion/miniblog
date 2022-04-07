class Integer
  def to_alphabet
    to_s(26).tr('0-9a-p', 'a-z')
  end
end

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "tester#{(n - 1).to_alphabet}@example.com"
    end
    password { 'password' }
    sequence :name do |n|
      "tester#{(n - 1).to_alphabet}"
    end
    profile { '' }
    blog_url { '' }
  end
end
