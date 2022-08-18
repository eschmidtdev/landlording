# frozen_string_literal: true

class PropertyValidatorService < ApplicationService
  attr_reader :property_params, :user

  def initialize(property_params, current_user = nil)
    @user            = current_user
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
