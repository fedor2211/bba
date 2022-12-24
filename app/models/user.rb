class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :email, length: { maximum: 40 }, format: { with: /\A\w+@\w+\.[A-Za-z]+\z/ }
end
