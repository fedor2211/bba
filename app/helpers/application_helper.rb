module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(:common)
    else
      asset_path('user.png')
    end
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end

  def fa_icon(icon_class)
    content_tag "span", "", class: "fa-solid fa-#{icon_class}"
  end
end
