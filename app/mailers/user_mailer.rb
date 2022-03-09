# frozen_string_literal: true

# This klass is responsible for handling email methods
class UserMailer < ApplicationMailer
  def send_verification_email(user)
    @user = user

    mail(to: @user.email, subject: 'I-PROPERTY MANAGEMENT EMAIL-VERIFICATION')
  end

  def change_password(user, pass)
    @user     = user
    @password = pass

    mail(to: @user.email, subject: 'LAND LORDING CHANGE PASSWORD REQUEST')
  end

  def send_me_document(document)
    @user     = document&.user
    @document = document

    mail(to: @user.email, subject: "LAND LORDING #{@document&.name} DOCUMENT")
  end
end
