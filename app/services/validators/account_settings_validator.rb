# frozen_string_literal: true

module Validators
  class AccountSettingsValidator < ApplicationService
    attr_reader :request, :params, :user

    MESSAGES = {
      incorrect: I18n.t('AccountSettings.Incorrect'),
      doesnt_match: I18n.t('AccountSettings.DoesntMatch'),
      missing_params: I18n.t('GeneralError.ParamsMissing'),
      billing_deleted: I18n.t('AccountSettings.BillingDeleted')
    }.freeze

    def initialize(request, params, user)
      @user    = user
      @params  = params
      @request = request
    end

    def call
      case request
      when 'update'
        check_account_params
      when 'update_password'
        check_password_params
      else
        # type code here
      end
    end

    def check_account_params
      unless (required_personal_info_keys - params.keys.sort).empty?
        { message: MESSAGES[:missing_params], method: '', url: nil }
      end
    end

    def check_password_params
      unless (required_password_params - params.keys.sort).empty?
        { message: MESSAGES[:missing_params], method: '', url: nil }
      end
    end

    def required_personal_info_keys
      %w[address_line_one address_line_two city company_name country first_name last_name phone_number postal_code state]
    end

    def required_password_params
      %w[confirm_password current_password new_password]
    end

  end
end
