# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController

  MESSAGES = {
    went_wrong: I18n.t('GeneralError.WentWrong')
  }.freeze

  def create
    response = PasswordValidatorService.call(params[:user][:email])
    return render_response(false, response, nil) unless response.nil?

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    return render_response(true, {}, confirmation_url) if successfully_sent?(resource)

    render_response(false, { message: MESSAGES[:went_wrong] }, nil)
  end

  def confirmation; end

  private

  def render_response(success, response, url)
    render json: { success:,
                   message: response[:message],
                   url: }
  end

end
