# frozen_string_literal: true

module Validators
  class PropertyValidatorService < ApplicationService
    attr_reader :request, :property_params, :user

    def initialize(request, property_params, current_user = nil)
      @request = request
      @user = current_user
      @property_params = property_params
    end

    def call
      validate_request
    end

    def validate_request
      case request
      when 'create'
        check_property_params
      when 'fetch_landlord'
        check_user
      else
        # type code here
      end

    end

    def check_user
      if user.email.blank?
        { message: MESSAGES[:add_email], method: 'add_email', url: '' }
      elsif user.phone_number.blank?
        { message: MESSAGES[:add_phone], method: 'add_phone', url: '' }
      elsif user.first_name.blank? && user.last_name.blank?
        { message: MESSAGES[:add_name], method: 'add_name', url: '' }
      end
    end

    def check_property_params
      unless required_keys.all? { |s| property_params.key? s }
        { message: MESSAGES[:missing_params], method: '', url: '' }
      end
    end

    def required_keys
      %i[property_type tenant_notice_street_line_one postal_code city state]
    end

  end
end
