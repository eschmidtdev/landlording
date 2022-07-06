# frozen_string_literal: true

class PropertyValidatorService < ApplicationService
  attr_reader :property_params, :user

  MESSAGES = {
    missing_params: I18n.t('GeneralError.ParamsMissing'),
    went_wrong: I18n.t('GeneralError.WentWrong'),
    add_phone: I18n.t('Properties.AddPhone')
  }.freeze

  def initialize(property_params, current_user = nil)
    @user = current_user
    @property_params = property_params
  end

  def call
    params_missing? || check_granted || check_user
  end

  def params_missing?
    { message: MESSAGES[:missing_params] } if property_params.empty?
  end

  def check_granted
    { message: MESSAGES[:went_wrong] } unless property_params['saved_landlord'] == 'true'
  end

  def check_user
    { message: MESSAGES[:add_phone] } if user.phone_number.blank?
  end

end
