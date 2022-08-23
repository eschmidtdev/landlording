# frozen_string_literal: true

module Validators
  class PaymentDetailsValidator < ApplicationService
    attr_reader :request, :params, :user

    def initialize(request, params, payment_detail)
      @params  = params
      @request = request
      @user    = payment_detail.user
    end
  end

  def call
    binding.pry
    case request
    when 'update'
      check_update_params
    else
      # type code here
    end
  end

  private

  def check_update_params
    binding.pry
  end

end
