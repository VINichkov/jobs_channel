class CallbacksController < Devise::OmniauthCallbacksController
  def telegram
    logger.info '------------------------------from_omniauth'
    logger.info request.env
    logger.info '------------------------------from_omniauth'
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.info root_url
    sign_in_and_redirect @user
  end
end