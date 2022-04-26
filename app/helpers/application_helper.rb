# frozen_string_literal: true

# This module is responsible for method that is (mostly) used in your Rails views to share reusable code
module ApplicationHelper
  def from_e_form_tab?
    params[:controller] == 'subscriptions' ||
      params[:controller] == 'documents' ||
      params[:controller] == 'payments' ||
      params[:controller] == 'registrations' ||
      params[:controller] == 'visitors'
  end

  def check_for(value)
    value.present? ? value : ''
  end

  def check_for_home_path
    user_signed_in? ? documents_path : root_path
  end
end
