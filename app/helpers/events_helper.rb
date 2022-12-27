module EventsHelper
  def current_user_can_subscribe?(event)
    event.user != current_user && !event.subscribers.include?(current_user)
  end
end
