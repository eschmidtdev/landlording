# frozen_string_literal: true

module PaymentDetails
  class PaymentDetailsService < ApplicationService
    attr_accessor :request, :params, :user

    def initialize(request, params, user)
      @user    = user
      @params  = params
      @request = request
    end

    def call
      return update_payment_detail if request == 'update'

      create_payment_details
    end

    private

    def update_payment_detail
      user.payment_detail.update!(params)
      { success: true, message: 'Payment details has been updated successfully.' }
    end

    def create_payment_details
      user.create_payment_detail!(params)
      { success: true, message: 'Payment details has been added successfully.' }
    end
  end
end
