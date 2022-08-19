# frozen_string_literal: true

module Validators
  class AccountSettingsValidatorService < ApplicationService
    attr_reader :request, :settings_params, :user

    MESSAGES = {
      incorrect: I18n.t('AccountSettings.Incorrect'),
      doesnt_match: I18n.t('AccountSettings.DoesntMatch'),
      missing_params: I18n.t('GeneralError.ParamsMissing'),
      billing_deleted: I18n.t('AccountSettings.BillingDeleted')
    }.freeze

    def initialize(request, settings_params, user)
      @user            = user
      @request         = request
      @settings_params = settings_params
    end

    def call
      validate_request
    end

    def validate_request
      case request
      when 'update'
        check_account_settings_params
      else
        # type code here
      end
    end

    def check_account_settings_params
      unless required_keys.all? { |k| settings_params.key? k }
        { message: MESSAGES[:missing_params], method: '', url: nil }
      end
    end

    def required_keys
      %i[first_name last_name postal_code phone_number city state country postal_code]
    end

  end
end
