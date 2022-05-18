# frozen_string_literal: true

# This controller inherits from Devise::RegistrationsController & for Users Registrations
class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def index; end

  def create
    return if params_missing?(params[:user]) ||
              user_exists?(params[:user]) ||
              password_clashing?(params[:user][:password])

    resource = create_resource
    UserMailer.send_verification_email(resource).deliver_now!
    set_flash_message(:registrations, :signed_up_but_inactive)
    redirect_to root_path
  end

  private

  def params_missing?(params)
    safe_params = params.permit!.to_h
    hash_has_blank(safe_params)
  end

  def hash_has_blank(hash)
    hash.values.any? do |i|
      if i.empty?
        set_flash_message(:registrations, :missing_params)
        signup_path
      end
    end
  end

  def user_exists?(params)
    return unless User.exists?(email: params[:email])

    set_flash_message(:registrations, :email_taken)
    redirect_to signup_path
  end

  def password_clashing?(password)
    if password.length < set_minimum_password_length
      set_flash_message(:passwords, :min_length)
      redirect_to signup_path
    end
  end

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
end
