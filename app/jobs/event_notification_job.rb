class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(event, object)
    case object
    when Comment
      subscribers_emails(event, object).each do |mail|
        EventMailer.comment(event, object, mail).deliver_later
      end
    when Photo
      subscribers_emails(event, object).each do |mail|
        EventMailer.photo(event, object, mail).deliver_later
      end
    when Subscription
      EventMailer.subscription(event, object).deliver_later
    end
  end

  private

  def subscribers_emails(event, object)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    all_emails -= [object.user.email] if object.user.present?
    all_emails
  end
end
