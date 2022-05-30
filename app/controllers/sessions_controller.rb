# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  include SessionsHelper

  def index
    redirect_to visitors_url if user_signed_in?
  end

  def new
    set_flash_message(:notice, :invalid)
    redirect_to root_path
  end

  def create
    user = set_user
    if user && user.confirmed_at.nil?
      render json: { success: false,
                     message: I18n.t('devise.registrations.signed_up_but_inactive') }
    elsif user.blank? || !user.valid_password?(params[:user][:password])
      render json: { success: false,
                     message: 'Wrong email or password. Try again or click Forgot password to reset it.' }
    else
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      render json: { success: true, message: I18n.t('devise.sessions.signed_in'),
                     url: redirect_url }
      session[:return_to] = nil unless session[:return_to].blank?
    end
  end

  def google_auth
    user = CreateOAuthUserService.new(auth).call
    sign_in user
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    redirect_to visitors_url
  end

  private

  def set_user
    User.find_by(email: params[:user][:email])
  end

  def auth
    request.env['omniauth.auth']
  end

  def redirect_url
    request.base_url
  end
end
