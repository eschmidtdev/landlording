# frozen_string_literal: true

module Validators
  class PasswordValidator < ApplicationService
    attr_accessor :params, :user

    def initialize(params, user)
      @user   = user
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
      error_response("Couldn't find user with provided email") if user.nil?
    end

    def required_keys = %i[email]

  end
end
