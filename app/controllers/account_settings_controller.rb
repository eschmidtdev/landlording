# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: %i[update destroy update_password]
  before_action :validate_account_setting, only: %i[update update_password]

  include Responseable

  def update
    resp = AccountSettings::AccountSettingsUpdate.call(params[:action], personal_info_params.to_h, @user)
    render_message(resp)
    redirect_to(account_path)
  end

  def update_password
    resp = AccountSettings::AccountSettingsUpdate.call(params[:action], password_params.to_h, @user)
    bypass_sign_in(@user)
    render_message(resp)
    redirect_to(account_path)
  end

  def destroy
    @user.payment_detail.destroy!
    flash[:notice] = 'Billing Details has been deleted successfully.'
    redirect_to(account_path)
  end

  def account_index
    @payment_detail = current_user.payment_detail
  end

  def change_password; end

  private

  def set_user = @user = User.find(params[:id])

  def personal_info_params
    id = ['id']
    params.require(:account_setting).permit(User.column_names.reject { |k| id.include?(k) }.map(&:to_sym))
  end

  def password_params
    params.require(:account_setting).permit(:current_password, :new_password, :confirm_password)
  end

  def validate_account_setting
    resp = Validators::AccountSettingsValidator.call(params[:action], set_params.to_h, @user)
    return if resp.nil?

    render_message(resp)
    redirect_to(account_path)
  end

  def set_params
    return personal_info_params if params[:action] == 'update'

    password_params
  end
end
