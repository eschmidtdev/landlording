# frozen_string_literal: true

# Service for create Admin User
class CreateAdminService
  attr_reader :name, :email, :pass, :token, :current_datetime

  def initialize(name, email, pass, token, current_datetime)
    @name = name
    @email = email
    @pass = pass
    @confirmation_token = token
    @datetime = current_datetime
  end

  def call
    prev_user = User.find_by email: @email
    raise StandardError, I18n.t('EForm.Messages.Error.AlreadyExists') if prev_user.present?

    User.create(
      name: @name,
      email: @email,
      password: @pass,
      confirmation_token: @confirmation_token,
      confirmed_at: @datetime,
      confirmation_sent_at: @datetime
    )
  end
end
