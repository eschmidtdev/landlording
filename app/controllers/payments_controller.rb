# frozen_string_literal: true

# This controller is responsible for payment process
class PaymentsController < ApplicationController
  before_action :set_subscription, only: :index

  # rubocop:disable Lint/Void
  def index
    @subscription
    @countries = CS.countries.values.sort
  end

  # rubocop:enable Lint/Void

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
