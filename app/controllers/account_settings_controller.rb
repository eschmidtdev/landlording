# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: %i[update destroy]

  include Responseable

  MESSAGES = {
    deleted: I18n.t('AccountSettings.BillingDeleted')
  }.freeze

  def index; end

  def change_password; end

  def update
    response = AccountSettingsValidatorService.call(account_settings_params.to_h, @user)
    return render_response(false, response[:message], response[:method], nil) unless response.nil?

    resp = AccountSettingsUpdateService.call(account_settings_params.to_h, @user)
    render_response(resp[:success], resp[:message], nil, nil)
  end

  def destroy
    @user.payment_detail.destroy
    render_response(false, MESSAGES[:deleted], nil, nil)
  end

  private

  def set_user = @user = User.find(params[:id])

  def account_settings_params
    params.require(:account_setting).permit(required_params)
  end

  def required_params
    User.column_names.reject { |k| [' id '].include?(k) }.map(&:to_sym) + (update_pass_params)
  end

  def update_pass_params
    %i[new_password from current_password confirm_password]
  end

end
