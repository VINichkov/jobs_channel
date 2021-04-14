class CallbacksController < Devise::OmniauthCallbacksController
  def telegram
    req = request.env["omniauth.auth"]
    req[:provider] = :telegram
    @user = User.from_omniauth(req)
    sign_in_and_redirect @user
  end
end