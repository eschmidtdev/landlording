# frozen_string_literal: true

# This klass is responsible for handling email methods
class UserMailer < ApplicationMailer
  def send_verification_email(user)
    @user = user

    mail(to: @user.email, subject: 'I-PROPERTY MANAGEMENT EMAIL-VERIFICATION')
  end
end
