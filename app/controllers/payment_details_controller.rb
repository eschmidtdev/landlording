# frozen_string_literal: true

class PaymentDetailsController < ApplicationController
  before_action :set_payment_detail, only: :update

  def billing
    @from = params[:from] if params[:from].present?
  end

  def update
    if params[:payment_detail][:from].present?
      payment_detail = PaymentDetail.new(payment_detail_params)
      if payment_detail.save!
        render json: { success: true,
                       message: 'Information has been added successfully.' }
      else
        render json: { success: false,
                       message: payment_detail.error.full_messages }
      end
    else
      if @payment_detail.update(payment_detail_params)
        render json: { success: true,
                       message: 'Information has been updated successfully.' }
      end
    end
  end

  private

  def set_payment_detail = @payment_detail = User.find(params[:id]).payment_detail

  def payment_detail_params
    params.require(:payment_detail).permit(:exp, :cvc, :city, :state,
                                           :company, :country, :last_name, :first_name,
                                           :postal_code, :card_number, :address_line_one,
                                           :address_line_two, :user_id)
  end
end
