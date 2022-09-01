# frozen_string_literal: true

module Validators
  class RegistrationValidator < ApplicationService
    attr_reader :params, :user

    MESSAGES = {
      email_taken: I18n.t('Registrations.EmailTaken'),
      params_missing: I18n.t('GeneralError.ParamsMissing'),
      short_password: I18n.t('Registrations.ShortPassword'),
      email_not_valid: I18n.t('Registrations.EmailNotValid')
    }.freeze

    def initialize(params, user)
      @user = user
      @params = HashWithIndifferentAccess.new params
    end

    def call
      missing_params? || user_existence
    end

    private

    def missing_params?
      if !required_keys.all? { |s| params.key? s } || params.values.any?(&:blank?)
        error_response('Params missing or values are empty')
      end
    end

    def user_existence
      error_response(MESSAGES[:email_taken]) if user.present?
    end

    def required_keys = %i[first_name email password]

  end
end
