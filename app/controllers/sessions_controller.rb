# frozen_string_literal: true

# This Controller is responsible for user login
class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  include SessionsHelper

  def new
    set_flash_message(:notice, :invalid)
    redirect_to root_path
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.confirmed_at.nil?
      set_flash_message(:notice, :inactive) if is_navigational_format?
      redirect_to root_path
    else
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      if !session[:return_to].blank?
        redirect_to root_path
        session[:return_to] = nil
      else
        redirect_to documents_path
      end
    end
  end

  def google_auth
    user = CreateOAuthUserService.new(auth).call
    sign_in user
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    redirect_to documents_path
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def auth
    request.env['omniauth.auth']
  end
end
