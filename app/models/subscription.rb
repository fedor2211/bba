class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validate :not_event_host
  validate :user_email_unique

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id },
                         presence: true, format: /\A\w+@\w+\.[a-zA-Z]+\z/,
                         unless: -> { user.present? }

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

  def user_email_unique
    if !user.present? && User.where(email: user_email).exists?
      errors.add(:base, I18n.t("activerecord.errors.events.event_error"))
    end
  end
end
