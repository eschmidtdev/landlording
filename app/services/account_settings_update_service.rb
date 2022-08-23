# frozen_string_literal: true

class AccountSettingsUpdateService < ApplicationService
  attr_reader :request, :settings_params, :user

  include Devise::Controllers::SignInOut

  MESSAGES = {
    updated: I18n.t('AccountSettings.Updated'),
    not_updated: I18n.t('AccountSettings.NotUpdated'),
    info_updated: I18n.t('AccountSettings.InfoUpdated'),
    info_not_updated: I18n.t('AccountSettings.InfoNotUpdated')
  }.freeze

  def initialize(request, params, user)
    @user            = user
    @request         = request
    @settings_params = params
  end

  def call
    case request
    when 'update'
      update_account_settings
    when 'update_password'
      update_password
    else
      # type code here
    end
  end

  def update_password
    new_password  = settings_params['new_password']
    user.password = user.password_confirmation = new_password
    if user.save
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
