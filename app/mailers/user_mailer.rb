class UserMailer < ApplicationMailer

  def send_verification_email(user)
    @user = user

    mail(to: @user.email, subject: "Verification Email")
  end

end
