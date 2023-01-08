class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validate :not_event_host
  validate :email_not_registered, unless: -> { user.present? }

  validates :user, uniqueness: {
                     scope: :event_id,
                     message: I18n.t("activerecord.errors.subscriptions.user_subscribed")
                   },
                   if: -> { user.present? }
  validates :user_name, presence: true
  validates :user_email, presence: true, format: /\A\w+@\w+\.[a-zA-Z]+\z/,
                         uniqueness: {
                           scope: :event_id,
                           message: I18n.t("activerecord.errors.subscriptions.email_subscribed")
                         }

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  private

  def not_event_host
    if event.user == user
      errors.add(:base, I18n.t("activerecord.errors.events.user_error"))
    end
  end

  def email_not_registered
    if User.where(email: user_email).exists?
      errors.add(:base, I18n.t("activerecord.errors.events.event_error"))
    end
  end
end
