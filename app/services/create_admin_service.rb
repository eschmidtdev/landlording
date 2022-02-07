# frozen_string_literal: true

# Service for create Admin User
class CreateAdminService
  attr_reader :name, :email, :pass

  def initialize(name, email, pass)
    @name = name
    @email = email
    @pass = pass
  end

  def call
    prev_user = User.find_by email: @email
    raise StandardError, I18n.t('EForm.Messages.Error.AlreadyExists') if prev_user.present?

    User.create(name: @name, email: @email, password: @pass)
  end
end
