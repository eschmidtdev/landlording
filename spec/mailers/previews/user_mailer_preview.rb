# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_verification_email
    user = User.new(email: 'as@as.com', password: 'Test@123')

    UserMailer.send_verification_email(user)
  end
end
