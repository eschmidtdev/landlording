# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: %i[update destroy update_password]
  before_action :validate_account_setting, only: %i[update update_password]

  include Responseable

  MESSAGES = {
    deleted: I18n.t('AccountSettings.BillingDeleted')
  }.freeze

  def account_index; end

  def change_password; end

  def update
    resp = AccountSettingsUpdateService.call(params[:action], personal_info_params.to_h, @user)
    render_response(resp[:success], resp[:message], nil, nil)
  end

  def update_password
    resp = AccountSettingsUpdateService.call(params[:action], password_params.to_h, @user)
    flash[:notice] = resp[:message]
    redirect_to account_path
  end

  def destroy
    @user.payment_detail.destroy
    flash[:notice] = MESSAGES[:deleted]
    redirect_to account_path
  end

  private

  def set_user = @user = User.find(params[:id])

  def personal_info_params
    params.require(:account_setting).permit(User.column_names
                                                .reject { |k| [' id '].include?(k) }
                                                .map(&:to_sym))
  end

  def password_params
    params.require(:account_setting).permit(:current_password, :new_password, :confirm_password)
  end

  def validate_account_setting
    response = Validators::AccountSettingsValidator.call(params[:action], set_params.to_h, @user)
    unless response.nil?
      flash[:notice] = response[:message]
      redirect_to account_path
    end
  end

  def set_params
    case params[:action]
    when 'update'
      personal_info_params
    when 'update_password'
      password_params
    else
      # type code here
    end
  end

end
