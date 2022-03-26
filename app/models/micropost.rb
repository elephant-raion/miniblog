class Micropost < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }
  validates :posted_at, presence: true
end
