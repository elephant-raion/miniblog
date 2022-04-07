def lowercase_alphabets
  ('a'..'z').to_a
end

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "tester#{lowercase_alphabets[n - 1]}@example.com"
    end
    password { 'password' }
    sequence :name do |n|
      "tester#{lowercase_alphabets[n - 1]}"
    end
    profile { '' }
    blog_url { '' }
  end
end
