# frozen_string_literal: true

# This Controller is responsible for handling index actions
class VisitorsController < ApplicationController
  def index
    redirect_to documents_path if user_signed_in?
  end
end
