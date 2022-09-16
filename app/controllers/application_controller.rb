# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  skip_before_action :verify_authenticity_token, if: :desired_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name])
  end

  private

  def desired_controller?
    params[:controller] == 'passwords' ||
      params[:controller] == 'payment_details' ||
      params[:controller] == 'account_settings' ||
      params[:controller] == 'properties' ||
      params[:controller] == 'documents'
  end

end
