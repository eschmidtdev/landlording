module Validators
  class PaymentDetailsValidator < ApplicationService
    attr_reader :request, :params, :user

    def initialize(request, params, user)
      @user = user
      @params = params
      @request = request
    end

    def call
      case request
      when 'fetch_landlord'
        check_user_attributes
      else
        # type code here
      end
    end

    private

    def check_user_attributes
      message = ''
      if user.address_line_one.blank?
        message = 'Please update Address Line 1 in account settings first.'
      elsif user.postal_code.blank?
        message = 'Please update Postal Code in account settings first.'
      end

      return error_response(message) unless message.blank?

      nil
    end

  end
end
