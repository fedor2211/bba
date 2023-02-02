class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(event, resource)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    all_emails -= [resource.user.email] if resource.user.present?
    mailer = EventMailer.method(resource.class.to_s.downcase)
    all_emails.each do |mail|
      mailer.call(event, resource, mail).deliver_later
    end
  end
end
