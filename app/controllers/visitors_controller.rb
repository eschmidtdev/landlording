# frozen_string_literal: true

class VisitorsController < ApplicationController
  def index
    redirect_to documents_path if user_signed_in?
  end
end
