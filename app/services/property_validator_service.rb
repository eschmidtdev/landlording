# frozen_string_literal: true

class PropertyValidatorService < ApplicationService
  attr_reader :property_params, :user

  MESSAGES = {
    missing_params: I18n.t('GeneralError.ParamsMissing'),
    add_phone: I18n.t('Properties.AddPhone'),
    went_wrong: I18n.t('GeneralError.WentWrong'),
    add_email: I18n.t('Properties.AddEmail'),
    add_name: I18n.t('Properties.AddName')
  }.freeze

  def initialize(property_params, current_user = nil)
    @user = current_user
    @property_params = property_params
  end

  def call
    params_missing? || check_user
  end

  def params_missing?
    { message: MESSAGES[:missing_params] } if property_params.empty?
  end

  def check_user
    if user.email.blank?
      { message: MESSAGES[:add_email], method: 'add_email' }
    elsif user.phone_number.blank?
      { message: MESSAGES[:add_phone], method: 'add_phone' }
    elsif user.first_name.blank? && user.last_name.blank?
      { message: MESSAGES[:add_name], method: 'add_name' }
    end
  end

end
