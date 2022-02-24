# frozen_string_literal: true

# This controller is responsible for payment process
class PaymentsController < ApplicationController
  before_action :set_subscription, only: :index

  def index
    @subscription
    @countries = CS.countries.values.sort
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
