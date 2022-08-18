# frozen_string_literal: true

# This module is responsible for method that is (mostly) used in your Rails
# views to share reusable code
module ApplicationHelper

  def check_for(value)
    value.present? ? value : ''
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
    elsif params[:controller] == 'payment_details' && params[:action] == 'index'
      'Enter Payment Details'
    end
  end

  def user_name(user)
    if user&.first_name.present? && user&.last_name.blank?
      user.first_name
    elsif user&.first_name.present? && user&.last_name.present?
      "#{user.first_name}  #{user.last_name}"
    end
  end

end
