# frozen_string_literal: true

# This module is responsible for method that is (mostly) used in your Rails
# views to share reusable code
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

  def current?(key, path)
    key.to_s if current_page? path
  end

  def heading(params)
    if params[:controller] == 'visitors' && params[:action] == 'index'
      'Account Overview'
    elsif params[:controller] == 'documents' && params[:action] == 'index'
      'My Documents'
    elsif params[:controller] == 'rental_applications' && params[:action] == 'index'
      'Rental Applications'
    elsif params[:controller] == 'properties' && params[:action] == 'index'
      'My Properties'
    elsif params[:controller] == 'properties' && params[:action] == 'new'
      'Add Rental Property'
    elsif params[:controller] == 'properties' && params[:action] == 'edit'
      'Edit Rental Property'
    elsif params[:controller] == 'account_settings' && params[:action] == 'index'
      'Account Settings'
    elsif params[:controller] == 'account_settings' && params[:action] == 'change_password'
      'Change Password'
    elsif params[:controller] == 'subscriptions' && params[:action] == 'index'
      'My Subscription'
    elsif params[:controller] == 'subscriptions' && params[:action] == 'cancel_subscription'
      'Cancel Subscription'
    elsif params[:controller] == 'payments' && params[:action] == 'index'
      'Enter Payment Details'
    end

  end
end
