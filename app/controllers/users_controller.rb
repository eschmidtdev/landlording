# frozen_string_literal: true

# This Controller is responsible for users operations
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to :back, alert: 'Access denied.' unless @user == current_user
  end
end
