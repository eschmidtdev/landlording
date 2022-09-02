# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[create validate_password]
  before_action :validate_password, only: :create

  include Responseable

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      return render_response(true, '', '', confirmation_url)
    end

    render_response(false, I18n.t('GeneralError.WentWrong'), nil, nil)
  end

  def confirmation; end

  private

  def set_user = @user = User.find_by(email: params[:user][:email])

  def validate_password
    resp = Validators::PasswordValidator.call(permitted_params, @user)
    return if resp.nil?

    render_message(resp)
    redirect_to '/users/password/new'
  end

  def permitted_params = params.require(:user).permit(:email)

end
