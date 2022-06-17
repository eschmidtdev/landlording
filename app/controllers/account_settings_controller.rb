# frozen_string_literal: true

class AccountSettingsController < ApplicationController
  before_action :set_user, only: :update

  def index; end

  def change_password; end

  def update
    if params[:account_setting][:from].present? && params[:account_setting][:from] == 'ChangePassword'
      if !@user.valid_password?(params[:account_setting][:current_password])
        render json: { success: false,
                       message: 'Password Incorrect.',
                       error: 'current_password' }
      elsif params[:account_setting][:new_password] != params[:account_setting][:confirm_password]
        render json: { success: false,
                       message: "Password confirmation doesn't match",
                       from: 'passwords_not_matched' }
      else
        @user.password = @user.password_confirmation = params[:account_setting][:new_password]
        if @user.save
          bypass_sign_in(@user)
          render json: { success: true,
                         message: 'Password has been updated successfully.' }
        else
          render json: { success: true,
                         message: 'Password can not be updated successfully.' }
        end
      end
    else
      if @user.update(account_settings_params)
        render json: { success: true,
                       message: 'Personal Information has been updated successfully.' }
      else
        render json: { success: false,
                       message: 'Personal Information can not be updated successfully.' }
      end
    end
  end

  private

  def set_user = @user = User.find(params[:id])

  def account_settings_params
    params.require(:account_setting).permit(:first_name,
                                            :last_name,
                                            :phone_number,
                                            :company_name)
  end
end
