# frozen_string_literal: true

# Service for create Admin User
class CreateAdminService < ApplicationService
  attr_reader :first_name, :last_name, :email, :password,
              :confirmation_token, :current_datetime, :phone_number

  def initialize(first_name, last_name, email, password, confirmation_token, current_datetime, phone_number)
    @email              = email
    @password           = password
    @last_name          = last_name
    @first_name         = first_name
    @phone_number       = phone_number
    @datetime           = current_datetime
    @confirmation_token = confirmation_token
  end

  def call
    prev_user = User.find_by email: @email
    if prev_user.present?
      raise StandardError, 'User already exists'
    end

    user = User.create(
      email:,
      password:,
      last_name:,
      first_name:,
      phone_number:,
      confirmation_token:,
      confirmed_at: current_datetime,
      confirmation_sent_at: current_datetime
    )
    user.save!
  end
end
