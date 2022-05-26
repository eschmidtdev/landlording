# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      redirect_to confirmation_path
    else
      respond_with(resource)
    end
  end

  def confirmation; end
end
