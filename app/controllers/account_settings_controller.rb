# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: %i[update destroy]

  include Responseable

  def index; end

  def change_password; end

  def update
    response = AccountSettingsValidatorService.call(account_settings_params.to_h, @user)
    return render_response(false, response[:message], nil, nil) unless response.nil?

    resp = AccountSettingsUpdateService.call(account_settings_params.to_h, @user)
    render_response(resp[:success], resp[:message], nil, nil)
  end

  def destroy
    @user.payment_detail.destroy
    render json: { success: true,
                   message: 'Billing Details has been deleted successfully.' }

  end

  private

  def set_user = @user = User.find(params[:id])

  def account_settings_params
    params.require(:account_setting).permit(required_params)
  end

  def required_params
    User.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

end
