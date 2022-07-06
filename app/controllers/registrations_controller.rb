# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  include Nameable
  include Responseable

  MESSAGES = {
    signed_up: I18n.t('Registrations.SignedUp')
  }.freeze

  def index; end

  def create
    response = RegistrationValidatorService.call(params)
    unless response.nil?
      return render_response(false, response[:message], response[:method], nil)
    end

    resource = create_resource
    # UserMailer.send_verification_email(resource).deliver_now!
    # render json: { success: true,
    #                url: email_confirmation_url }
    sign_in(resource)
    render_response(true, MESSAGES[:signed_up], nil, visitors_url)
  end

  def email_confirmation; end

  private

  def create_resource
    user                       = User.new(user_params)
    user.confirmation_token    = SecureRandom.hex(10)
    user.confirmed_at          = nil
    user.confirmation_sent_at  = DateTime.now
    user.password_confirmation = user.password
    construct_name(user, params)
    user.save!
    user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation)
  end

  def redirect_url
    signup_url
  end

end
