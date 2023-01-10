module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      url_for(user.avatar.variant(:common))
    else
      asset_path("user.png")
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.attached?
      url_for(user.avatar.variant(:thumb))
    else
      asset_path("user.png")
    end
  end

  def user_thumb_link(user)
    link_to(
      image_tag(user_avatar_thumb(user), class: "img-icon", title: user.name),
      user_path(user)
    )
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      url_for(photos.sample.photo.variant(:common))
    else
      asset_path("event.jpg")
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      url_for(photos.sample.photo.variant(:thumb))
    else
      asset_path("event_thumb.jpg")
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
