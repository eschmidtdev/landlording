# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :validate_registration, only: :create

  include Responseable

  def index; end

  def create
    resource = RegistrationCreateUserService.call(user_params)
    # UserMailer.send_verification_email(resource).deliver_now!
    # render json: { success: true,
    #                url: email_confirmation_url }
    sign_in(resource)
    render_response(true, 'Signed up successfully.', nil, root_path)
  end

  def email_confirmation; end

  private

  def user_params
    params.require(:user).permit(:first_name, :email, :password)
  end

  def validate_registration
    user = User.find_by(email: params[:user][:email])
    response = Validators::RegistrationValidator.call(user_params, user)
    render_response(false, response[:message], nil, nil) unless response.nil?
  end
end
