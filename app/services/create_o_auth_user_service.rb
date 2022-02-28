# frozen_string_literal: true

# This Service is responsible to for find or create user via google account
class CreateOAuthUserService
  attr_reader :auth, :name, :email, :token, :refresh_token, :password

  def initialize(auth)
    @auth = auth
    @name = auth['info']['name']
    @email = auth['info']['email']
    @token = auth.credentials.token
    @refresh_token = auth.credentials.refresh_token
    @password = SecureRandom.urlsafe_base64
  end

  def call
    User.find_or_create_by(uid: @auth['uid']) do |u|
      u.name = @name
      u.email = @email
      u.google_token = @token
      u.google_refresh_token = @refresh_token if @refresh_token.present?
      u.password = @password
    end
  end
end
