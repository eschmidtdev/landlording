# frozen_string_literal: true

class PaymentDetailsController < ApplicationController
  before_action :set_payment_detail, only: :update
  before_action :validate_payment_detail, only: :fetch_landlord

  def billing; end

  def update
    resp = PaymentDetails::PaymentDetailsService.call(set_action, payment_detail_params.to_h, User.find(params[:id]))
    flash[:notice] = resp[:message]
    redirect_to(account_path)
  end

  def fetch_landlord
    user = current_user
    render(json: {
      success: true,
      user: {
        city: user.city,
        state: user.state,
        country: user.country,
        last_name: user.last_name,
        company: user.company_name,
        first_name: user.first_name,
        postal_code: user.postal_code,
        address_line_one: user.address_line_one,
        address_line_two: user.address_line_two
      }
    }
          )
  end

  private

  def set_payment_detail = @payment_detail = User.find(params[:id]).payment_detail

  def validate_payment_detail
    resp = Validators::PaymentDetailsValidator.call(params[:action], params, current_user)
    render(json: resp) unless resp.nil? && request.xhr?
  end

  def payment_detail_params
    id = ['id']
    params.require(:payment_detail).permit(PaymentDetail.column_names.reject { |k| id.include?(k) }.map(&:to_sym))
  end

  def set_action
    @payment_detail.nil? ? 'create' : 'update'
  end
end
