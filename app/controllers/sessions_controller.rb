# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[create validate_session]
  before_action :validate_session, only: :create

  include Responseable

  def index; end

  def new
    redirect_to root_url
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    signed_in = sign_in(resource_name, resource)
    if signed_in
      flash[:notice] = 'Signed in successfully.'
      redirect_to root_url
    else
      render_response(true, 'Signed in successfully.', nil, root_url)
    end
    session[:return_to] = nil unless session[:return_to].blank?
  end

  def google_auth
    user = CreateOAuthUserService.new(auth).call
    sign_in user
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def set_user = @user = User.find_by(email: params[:user][:email])

  def validate_session
    response = Validators::SessionValidator.call(permitted_params, @user)
    render_response(false, response[:message], nil, nil) unless response.nil?
  end

  def permitted_params
    params.require(:user).permit(:email, :password)
  end

end
