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

  # rubocop:disable Metrics/MethodLength
  def call
    prev_user = User.find_by email: @email
    raise StandardError, I18n.t('EForm.Messages.Error.AlreadyExists') if prev_user.present?

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
  # rubocop:enable Metrics/MethodLength
end
