FactoryBot.define do
  factory :micropost do
    content { 'A short message' }
    posted_at { Time.current }
  end
end
