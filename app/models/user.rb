class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_one_attached :avatar do |attachable|
    attachable.variant :common, resize_to_fill: [400, 400]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true
  validates :email, length: { maximum: 40 }, format: { with: /\A\w+@\w+\.[A-Za-z]+\z/ }

  before_validation :set_name, on: :create
  after_commit :link_subscriptions

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
