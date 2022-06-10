# frozen_string_literal: true

class SessionValidatorService < ApplicationService
  attr_reader :password, :user

  def initialize(params)
    @user = get_user(params[:user][:email])
    @password = params[:user][:password]
  end

  def call
    user_confirmed? || does_not_exist?
  end

  private

  def user_confirmed?
    if user && user.confirmed_at.nil?
      { success: false,
        message: I18n.t('devise.registrations.signed_up_but_inactive') }
    end
  end

  def does_not_exist?
    if user.blank? || !user.valid_password?(password)

      { success: false,
        message: 'Wrong email or password.
                  Try again or click Forgot password to reset it.' }
    end
  end

  def get_user(email) = User.find_by(email:)
end
