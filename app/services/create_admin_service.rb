# frozen_string_literal: true

# Service for create Admin User
class CreateAdminService < ApplicationService
  def initialize(name, email, password, confirmation_token, current_datetime)
    @name               = name
    @email              = email
    @password           = password
    @datetime           = current_datetime
    @confirmation_token = confirmation_token
  end

  def call
    prev_user = User.find_by email: @email
    if prev_user.present?
      raise StandardError,
            I18n.t('EForm.Messages.Error.AlreadyExists')
    end

    user = User.create(
      name: @name,
      email: @email,
      password: @password,
      confirmed_at: @datetime,
      confirmation_sent_at: @datetime,
      confirmation_token: @confirmation_token
    )
    user.save!
  end
end
