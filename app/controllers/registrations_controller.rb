# frozen_string_literal: true

# This controller inherits from Devise::RegistrationsController & for Users Registrations
class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def index; end

  def create
    response = RegistrationValidatorService.call(params)
    return render_response(response) unless response.nil?

    resource = create_resource
    UserMailer.send_verification_email(resource).deliver_now!
    render json: { success: true,
                   message: I18n.t('devise.registrations.signed_up_but_inactive') }
  end

  private

  def create_resource
    user = User.new(user_params)
    user.confirmation_token = SecureRandom.hex(10)
    user.confirmed_at = nil
    user.confirmation_sent_at = DateTime.now
    user.password_confirmation = user.password
    user.save!
    user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def render_response(response)
    render json: { success: false,
                   method: response[:method],
                   message: response[:message] }
  end

  def redirect_url
    request.base_url + signup_path
  end
end
