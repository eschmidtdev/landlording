class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    return if params_missing?(params[:user]) || user_exists?(params[:user]) ||
      password_clashing?(params[:user][:password], params[:user][:password_confirmation])

    resource = User.new(user_params)
    resource.save
    set_flash_message(:registrations, :signed_up, options = {})
    redirect_to root_path
  end

  def update
    super
  end

  private

  def params_missing?(params)
    safe_params = params.permit!.to_h
    hash_has_blank(safe_params)
  end

  def hash_has_blank(hash)
    hash.values.any? do |i|
      if i.empty?
        set_flash_message(:registrations, :missing_params, options = {})
        redirect_to root_path
      end
    end

  end

  def user_exists?(params)
    if User.exists?(email: params[:email])
      set_flash_message(:registrations, :email_taken, options = {})
      redirect_to root_path
    end
  end

  def password_clashing?(password, confirm_password)
    if password.length < set_minimum_password_length
      set_flash_message(:passwords, :min_length, options = {})
      redirect_to root_path
    elsif password != confirm_password
      set_flash_message(:passwords, :invalid_confirmation, options = {})
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end