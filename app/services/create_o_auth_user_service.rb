# frozen_string_literal: true

# This Service is responsible to for find or create user via google account
class CreateOAuthUserService
  attr_reader :auth, :name, :email, :token, :refresh_token, :password

  def initialize(auth)
    @auth          = auth
    @name          = auth['info']['name']
    @email         = auth['info']['email']
    @token         = auth.credentials.token
    @password      = SecureRandom.urlsafe_base64
    @refresh_token = auth.credentials.refresh_token
  end

  def call
    User.find_or_create_by(uid: @auth['uid']) do |u|
      u.name                 = @name
      u.email                = @email
      u.password             = @password
      u.google_token         = @token
      u.confirmed_at         = DateTime.now
      u.google_refresh_token = @refresh_token if @refresh_token.present?
    end
  end
end
