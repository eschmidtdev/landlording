# frozen_string_literal: true

module Validators
  class AccountSettingsValidator < ApplicationService
    attr_reader :request, :params, :user

    def initialize(request, params, user)
      @user    = user
      @params  = params
      @request = request
    end

    def call
      return check_account_params if request == 'update'

      check_password_params
    end

    def check_account_params
      resp_hash unless (required_personal_info_keys - params.keys.sort).empty?
    end

    def check_password_params
      resp_hash unless (required_password_params - params.keys.sort).empty?
    end

    def required_personal_info_keys
      %w[address_line_one address_line_two city
         company_name country first_name last_name
         phone_number postal_code state]
    end

    def required_password_params
      %w[confirm_password current_password new_password]
    end

    def resp_hash
      { message: 'Params are missing or values are empty.', method: '', url: nil }
    end

  end
end
