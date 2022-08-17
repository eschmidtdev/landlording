# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  include Responseable
  include SessionsHelper

  MESSAGES = {
    signed_in: I18n.t('devise.sessions.signed_in')
  }.freeze

  def index; end

  def new
    set_flash_message(:notice, :invalid)
    redirect_to root_url
  end

  def create
    response = SessionValidatorService.call(params)
    return render_response(false, response[:message], nil, nil) unless response.nil?

    self.resource = warden.authenticate!(auth_options)
    signed_in = sign_in(resource_name, resource)
    if signed_in
      flash[:notice] = 'Signed in successfully.'
      redirect_to root_url
    else
      render_response(true, MESSAGES[:signed_in], nil, root_url)
    end
    session[:return_to] = nil unless session[:return_to].blank?
  end

  def google_auth
    user = CreateOAuthUserService.new(auth).call
    sign_in user
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    redirect_to visitors_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
