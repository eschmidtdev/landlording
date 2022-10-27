# frozen_string_literal: true

module Validators
  class SessionValidator < ApplicationService
    attr_reader :params, :user

    MESSAGES = {
      not_valid: I18n.t('Sessions.NotValid'),
      not_confirmed: I18n.t('devise.registrations.signed_up_but_inactive')
    }.freeze
    private_constant :MESSAGES

    def initialize(params, user)
      @user = user
      @params = HashWithIndifferentAccess.new(params)
    end

    def call
      missing_params? || user_existence || user_confirmation
    end

    private

    def missing_params?
      error_response('Params missing or values are empty') if !required_keys.all? { |s| params.key?(s) } || params.values.any?(&:blank?)
    end

    def user_confirmation
      error_response(MESSAGES[:not_confirmed]) if user.not_confirmed?
    end

    def user_existence
      error_response(MESSAGES[:not_valid]) if user.nil? || !user.valid_password?(params['password'])
    end

    def required_keys = %i[email password]
  end
end
