class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z]+\Z/ }
  validates :profile, length: { maximum: 200 }
  validates :url, url: { allow_blank: true }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
