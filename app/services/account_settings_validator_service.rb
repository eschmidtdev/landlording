# frozen_string_literal: true

class AccountSettingsValidatorService < ApplicationService
  attr_reader :settings_params, :user

  MESSAGES = {
    incorrect: I18n.t('AccountSettings.Incorrect'),
    doesnt_match: I18n.t('AccountSettings.DoesntMatch'),
    missing_params: I18n.t('GeneralError.ParamsMissing'),
    billing_deleted: I18n.t('AccountSettings.BillingDeleted')
  }.freeze

  def initialize(params, user)
    @user = user
    @settings_params = params
  end

  def call
    params_missing? || ((invalid? || doesnt_match?) if change_password?)
  end

  def params_missing?
    { message: MESSAGES[:missing_params] } if settings_params.empty?
  end

  def change_password?
    settings_params['from'].present? && settings_params['from'] == 'ChangePassword'
  end

  def invalid?
    unless user.valid_password?(settings_params['current_password'])
      { message: MESSAGES[:incorrect], method: 'invalid?' }
    end
  end

  def doesnt_match?
    if settings_params['new_password'] != settings_params['confirm_password']
      { message: MESSAGES[:doesnt_match], method: 'doesnt_match?' }
    end
  end

end
