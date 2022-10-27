# frozen_string_literal: true

module Validators
  class PaymentDetailsValidator < ApplicationService
    attr_reader :request, :params, :user

    def initialize(request, params, user)
      @user    = user
      @params  = params
      @request = request
    end

    def call
      return check_user_attributes if request == 'fetch_landlord'

      nil
    end

    private

    def check_user_attributes
      message = ''
      message = render_message(message)
      return error_response(message) if message.present?

      nil
    end

    def render_message(message)
      if user.address_line_one.blank?
        message = 'Please update Address Line 1 in account settings first.'
      elsif user.postal_code.blank?
        message = 'Please update Postal Code in account settings first.'
      else
        message
      end
      message
    end
  end
end
