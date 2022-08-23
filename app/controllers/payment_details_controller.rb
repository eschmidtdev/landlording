# frozen_string_literal: true

class PaymentDetailsController < ApplicationController
  before_action :set_payment_detail, only: :update
  before_action :validate_payment_detail, only: :update

  def billing; end

  def update
    binding.pry
    if params[:payment_detail][:from].present?
      payment_detail = PaymentDetail.new(payment_detail_params)
      if payment_detail.save!
        flash[:notice] = 'Payment details were successfully added.'
      else
        flash[:error] = payment_detail.error.full_messages
      end
      redirect_to account_setting_path
    else
      if @payment_detail.update(payment_detail_params)
        flash[:notice] = 'Payment details were successfully updated.'
        redirect_to account_setting_path
      end
    end
  end

  def fetch_landlord
    user = current_user
    render json: {
      success: true,
      user: {
        city: user.city,
        state: user.state,
        country: user.country,
        company: user.company_name,
        last_name: user.last_name,
        first_name: user.first_name,
        postal_code: user.postal_code,
        address_line_one: user.address_line_one,
        address_line_two: user.address_line_two
      }
    }
  end

  private

  def set_payment_detail = @payment_detail = User.find(params[:id]).payment_detail

  def payment_detail_params
    params.require(:payment_detail).permit(PaymentDetail.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym))
  end

  def validate_payment_detail
    binding.pry
    response = Validators::PaymentDetailsValidator.call(params[:action], payment_detail_params.to_h, @payment_detail)
    unless response.nil?
      flash[:notice] = response[:message]
      redirect_to billing_path
    end
  end

end
