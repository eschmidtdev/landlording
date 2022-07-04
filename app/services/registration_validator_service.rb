# frozen_string_literal: true

class RegistrationValidatorService < ApplicationService
  attr_reader :user_params, :password_params

  MESSAGES = {
    params_missing: I18n.t('GeneralError.ParamsMissing'),
    email_taken: I18n.t('Registrations.EmailTaken'),
    short_password: I18n.t('Registrations.ShortPassword')
  }.freeze

  def initialize(params)
    @user_params     = params[:user]
    @password_params = params[:user][:password]
  end

  def call
    params_missing?(user_params) ||
      user_exists?(user_params) ||
      password_clashing?(password_params)
  end

  private

  def params_missing?(params)
    safe_params = params.permit!.to_h
    hash_has_blank(safe_params)
  end

  def hash_has_blank(hash)
    hash.values.any? do |i|
      if i.blank?
        return { method: 'params_missing?',
                 message: MESSAGES[:params_missing] }
      end
    end
  end

  def user_exists?(params)
    if User.exists?(email: params[:email])
      return { method: 'user_exists?',
               message: MESSAGES[:email_taken] }
    end
  end

  def password_clashing?(password)
    if password.length < 8
      return { method: 'password_clashing?',
               message: MESSAGES[:short_password] }
    end
  end
end
