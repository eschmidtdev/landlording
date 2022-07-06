# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  include Responseable

  MESSAGES = {
    went_wrong: I18n.t('GeneralError.WentWrong')
  }.freeze

  def create
    response = PasswordValidatorService.call(params[:user][:email])
    return render_response(false, response[:message], nil, nil) unless response.nil?

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      return render_response(true, '', confirmation_url, nil)
    end

    render_response(false, MESSAGES[:went_wrong], nil, nil)
  end

  def confirmation; end

end
