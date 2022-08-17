# frozen_string_literal: true

class VisitorsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    redirect_to login_url unless user_signed_in?
  end

end
