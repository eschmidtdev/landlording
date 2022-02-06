class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def new
    set_flash_message(:notice, :invalid)
    redirect_to root_path
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to root_path
      session[:return_to] = nil
    else
      redirect_to e_forms_path
    end
  end
end