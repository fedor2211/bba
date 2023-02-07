class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(object)
    @event = object.event
    case object
    when Comment
      subscribers_emails(object).each do |mail|
        EventMailer.comment(object, mail).deliver_later
      end
    when Photo
      subscribers_emails(object).each do |mail|
        EventMailer.photo(object, mail).deliver_later
      end
    when Subscription
      EventMailer.subscription(object).deliver_later
    end
  end

  private

  def subscribers_emails(object)
    all_emails = (@event.subscriptions.map(&:user_email) + [@event.user.email]).uniq
    all_emails -= [object.user.email] if object.user.present?
    all_emails
  end
end
