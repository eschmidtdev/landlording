# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: :update

  def index; end

  def change_password; end

  def update
    if @user.update(account_settings_params)
      render json: { success: true,
                     message: 'Personal Information has been updated successfully.' }
    else
      render json: { success: false,
                     message: 'Personal Information can not be updated successfully.' }
    end
  end

  private

  def set_user = @user = User.find(params[:id])

  def account_settings_params
    params.require(:account_setting).permit(:first_name, :last_name, :phone_number, :company_name)
  end
end
