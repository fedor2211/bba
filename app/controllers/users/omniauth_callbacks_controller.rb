class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      if is_navigational_format?
        set_flash_message(:notice, :failure,
                          kind: "Github",
                          reason: @user.errors.full_messages.join(" "))
      end
      session["devise.github_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def vkontakte
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Vkontakte") if is_navigational_format?
    else
      if is_navigational_format?
        set_flash_message(:notice, :failure,
                          kind: "Vkontakte",
                          reason: @user.errors.full_messages.join(" "))
      end
      session["devise.vkontakte_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
