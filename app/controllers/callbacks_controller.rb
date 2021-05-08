class CallbacksController < Devise::OmniauthCallbacksController
  def telegram
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.info root_url
    sign_in_and_redirect @user
  end
end