require "open-uri"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[github vkontakte]
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_one_attached :avatar do |attachable|
    attachable.variant :common, resize_to_fill: [400, 400]
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true
  validates :email, length: { maximum: 40 },
                    format: { with: /\A[\w.]+@[\w.]+\.[A-Za-z]+\z/ }

  before_validation :set_name, on: :create
  after_commit :link_subscriptions

  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    unless user.present?
      user = new
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] unless user.password.present?
      user.name = auth.info.name
    end
    user.skip_confirmation!
    user.save
    user
  end

  def attach_avatar_from_url(url)
    parsed_url = URI.parse(url)
    filename = File.basename(parsed_url.path)
    file = URI.open(parsed_url)
    self.avatar.attach(io: file, filename: filename)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
