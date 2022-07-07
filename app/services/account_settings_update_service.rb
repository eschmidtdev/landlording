# frozen_string_literal: true

class AccountSettingsUpdateService < ApplicationService
  attr_reader :settings_params, :user

  MESSAGES = {
    updated: I18n.t('AccountSettings.Updated'),
    not_updated: I18n.t('AccountSettings.NotUpdated'),
    info_updated: I18n.t('AccountSettings.InfoUpdated'),
    info_not_updated: I18n.t('AccountSettings.InfoNotUpdated')
  }.freeze

  def initialize(params, user)
    @user            = user
    @settings_params = params
  end

  def call
    update_password if change_password?

    update_account_settings
  end

  def change_password?
    settings_params['from'] == 'ChangePassword'
  end

  def update_password
    new_password  = settings_params['new_password']
    user.password = user.password_confirmation = new_password
    if user.save
      bypass_sign_in(user)
      { success: true, message: MESSAGES[:updated] }
    else
      { success: false, message: MESSAGES[:not_updated] }
    end
  end

  def update_account_settings
    if user.update(settings_params)
      { success: true, message: MESSAGES[:info_updated] }
    else
      { success: false, message: MESSAGES[:info_not_updated] }
    end
  end

end
