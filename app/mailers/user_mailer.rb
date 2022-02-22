class UserMailer < ApplicationMailer

  def send_verification_email(user)
    @user = user

    mail(to: @user.email, subject: "I-PROPERTY MANAGEMENT EMAIL-VERIFICATION")
  end

end
