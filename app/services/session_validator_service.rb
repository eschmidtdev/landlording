# frozen_string_literal: true

class SessionValidatorService < ApplicationService
  attr_reader :password, :user

  MESSAGES = {
    not_valid: I18n.t('Sessions.Messages.Success.NotValid'),
    not_confirmed: I18n.t('devise.registrations.signed_up_but_inactive')

  }.freeze

  def initialize(params)
    @user     = get_user(params[:user][:email])
    @password = params[:user][:password]
  end

  def call
    user_confirmed? || does_not_exist?
  end

  private

  def user_confirmed?
    { message: MESSAGES[:not_confirmed] } if user && user.confirmed_at.nil?
  end

  def does_not_exist?
    { message: MESSAGES[:not_valid] } if user.blank? || !user.valid_password?(password)
  end

  def get_user(email) = User.find_by(email:)
end
