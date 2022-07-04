# frozen_string_literal: true

class PasswordValidatorService < ApplicationService
  attr_accessor :email

  MESSAGES = {
    params_missing: I18n.t('GeneralError.ParamsMissing')
  }.freeze

  def initialize(email)
    @email = email
  end

  def call = missing_params?

  private

  def missing_params?
    { message: MESSAGES[:params_missing] } if email.blank?
  end
end
