# frozen_string_literal: true

class RegistrationCreateUserService < ApplicationService
  include Nameable

  attr_reader :user_params

  def initialize(params)
    @user_params = params
  end

  def call
    user                       = User.new(user_params)
    user.confirmed_at          = nil
    user.confirmation_sent_at  = DateTime.now
    user.password_confirmation = user.password
    user.uuid                  = SecureRandom.uuid
    user.confirmation_token    = SecureRandom.hex(10)
    construct_name(user, user_params)
    user.save!
    user
  end
end
