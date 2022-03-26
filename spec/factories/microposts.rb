FactoryBot.define do
  factory :micropost do
    content { 'A short message' }
    posted_at { Date.current }
  end
end
