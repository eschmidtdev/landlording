# frozen_string_literal: true

# This controller is responsible for manage subscription
class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[update plans]

  def index
    @subscription = current_user.subscription
    @countries = CS.countries.values.sort
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to subscriptions_url, notice: 'Your details were successfully saved.'
    else
      redirect_to subscriptions_url, notice: 'Some went wrong please update again.'
    end
  end

  def plans; end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.permit(:email, :first_name, :last_name, :company, :address_line_one, :address_line_two, :city,
                  :zip_code, :country, :state, :user_id)
  end
end
