# frozen_string_literal: true

module AccountSettings
  class AccountSettingsUpdate < ApplicationService
    attr_reader :request, :settings_params, :user

    MESSAGES = {
      updated: I18n.t('AccountSettings.Updated'),
      not_updated: I18n.t('AccountSettings.NotUpdated'),
      info_updated: I18n.t('AccountSettings.InfoUpdated')
    }.freeze

    def initialize(request, params, user)
      @user            = user
      @request         = request
      @settings_params = params
    end

    def call
      return update_account_settings if request == 'update'

      update_password
    end

    def update_password
      new_password = settings_params['new_password']
      user.password = user.password_confirmation = new_password
      return success_response(MESSAGES[:updated]) if user.save

      error_response(MESSAGES[:not_updated])
    end

    def update_account_settings
      return success_response(MESSAGES[:info_updated]) if user.update(settings_params)

      error_response(user.errors.full_messages.join(', '))
    end

  end
end
