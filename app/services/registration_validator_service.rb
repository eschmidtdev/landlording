# frozen_string_literal: true

class RegistrationValidatorService < ApplicationService
  attr_reader :user_params, :password_params

  def initialize(params)
    @user_params = params[:user]
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
                 message: 'Params are missing or values are empty' }
      end
    end
  end

  def user_exists?(params)
    if User.exists?(email: params[:email])
      { method: 'user_exists?',
        message: 'Email has already been taken. Try Another' }
    end
  end

  def password_clashing?(password)
    if password.length < 8
      { method: 'password_clashing?',
        message: 'Password is too short (minimum is 8 characters)' }
    end
  end
end
