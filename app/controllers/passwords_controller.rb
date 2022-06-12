# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { success: true,
                     url: confirmation_url }
    else
      render json: { success: false,
                     message: 'Something went wrong. Please try again later.' }
    end
  end

  def confirmation; end

end
