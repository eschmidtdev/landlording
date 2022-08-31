# frozen_string_literal: true

module Validators
  class SessionValidator < ApplicationService
    attr_reader :params, :user

    MESSAGES = {
      not_valid: I18n.t('Sessions.NotValid'),
      not_confirmed: I18n.t('devise.registrations.signed_up_but_inactive')

    }.freeze

    def initialize(params, user)
      @user = user
      @params = HashWithIndifferentAccess.new params
    end

    def call
      missing_params? || user_confirmation || user_existence
    end

    private

    def missing_params?
      unless required_keys.all? { |s| params.key? s } || params.values.any?(&:blank?)
        error_response('Params missing or values are empty')
      end
    end

    def user_confirmation
      error_response(MESSAGES[:not_confirmed]) if user.not_confirmed?
    end

    def user_existence
      if user.nil? || !user.valid_password?(params['password'])
        error_response(MESSAGES[:not_valid])
      end
    end

    def required_keys = %i[email password]

  end
end
