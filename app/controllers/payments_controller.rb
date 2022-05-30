# frozen_string_literal: true

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
