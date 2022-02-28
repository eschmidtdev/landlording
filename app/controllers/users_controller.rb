# frozen_string_literal: true

# This Controller is responsible for users operations
class UsersController < ApplicationController
  before_action :authenticate_user!, except: :confirm_email

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to :back, alert: 'Access denied.' unless @user == current_user
  end

  def confirm_email
    user = User.find_by(id: params[:id])
    return unless user.present? && user.confirmation_token == params[:confirmation_token]

    user.confirmed_at = DateTime.now
    if user.save!
      redirect_to documents_path, notice: I18n.t('devise.sessions.signed_in')
      sign_in(user)
    else
      redirect_to root_path
    end
  end
end
