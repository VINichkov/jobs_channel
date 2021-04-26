class ApplicationController < ActionController::Base

  before_action :init_search
  if ENV["RAILS_ENV"] == 'production'
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from CanCan::AccessDenied, with: :not_found
    rescue_from ArgumentError, with: :not_found
  end

  #around_action  :switch_locale

  protect_from_forgery with: :exception

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.superadmin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  def  current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    logger.debug I18n.available_locales
    I18n.with_locale(locale, &action)
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def init_search
    @search = Search.new
  end

  def not_found
    render 'errors/not_found', status: :not_found, formats: :html
  end


end
