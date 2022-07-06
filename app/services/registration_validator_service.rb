# frozen_string_literal: true

class RegistrationValidatorService < ApplicationService
  attr_reader :user_params, :password_params

  MESSAGES = {
    email_taken: I18n.t('Registrations.EmailTaken'),
    params_missing: I18n.t('GeneralError.ParamsMissing'),
    short_password: I18n.t('Registrations.ShortPassword'),
    email_not_valid: I18n.t('Registrations.EmailNotValid')
  }.freeze

  def initialize(params)
    @user_params     = params[:user]
    @password_params = params[:user][:password]
  end

  def call
    params_missing?(user_params) ||
      user_exists?(user_params) ||
      password_clashing?(password_params) ||
      validate_email?(user_params)
  end

  private

  def params_missing?(params)
    safe_params = params.permit!.to_h
    hash_has_blank(safe_params)
  end

  def hash_has_blank(hash)
    hash.values.any? do |i|
      return { message: MESSAGES[:params_missing], method: 'params_missing?' } if i.blank?
    end
  end

  def user_exists?(params)
    if User.exists?(email: params[:email])
      { message: MESSAGES[:email_taken], method: 'user_exists?' }
    end
  end

  def password_clashing?(password)
    if password.length < 8
      { message: MESSAGES[:short_password], method: 'password_clashing?' }
    end
  end

  def validate_email?(params)
    unless (params[:email] =~ /^\S+@\S+\.\S+$/xi).present?
      { message: MESSAGES[:email_not_valid], method: 'validate_email?' }
    end
  end
end
