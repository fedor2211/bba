class EventMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.subscription.subject
  #
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{I18n.t('mailers.events.new_subscription')} #{event.title}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.comment.subject
  #
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{I18n.t('mailers.events.new_comment')} #{event.title}"
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: "#{I18n.t('mailers.events.new_photo')} #{event.title}"
  end
end
