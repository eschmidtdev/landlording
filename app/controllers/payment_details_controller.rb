# frozen_string_literal: true

class PaymentDetailsController < ApplicationController
  before_action :set_payment_detail, only: %i[update fetch_landlord]

  def billing
    @from = params[:from] if params[:from].present?
  end

  def update
    if params[:payment_detail][:from].present?
      payment_detail = PaymentDetail.new(payment_detail_params)
      if payment_detail.save!
        flash[:notice] = 'Payment details were successfully added.'
        redirect_to account_url
      else
        flash[:error] = payment_detail.error.full_messages
        redirect_to
      end
    else
      if @payment_detail.update(payment_detail_params)
        flash[:notice] = 'Payment details were successfully updated.'
        redirect_to account_url
      end
    end
  end

  def fetch_landlord
    return_user(current_user)
    if @payment_detail.update(payment_detail_params)
      flash[:notice] = 'Payment details were successfully updated.'
      redirect_to account_url
    end
  end

  private

  def set_payment_detail = @payment_detail = User.find(params[:id]).payment_detail

  def payment_detail_params
    params.require(:payment_detail).permit(white_list_params)
  end

  def white_list_params
    PaymentDetail.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def return_user(user)
    render json: {
      success: true,
      user: {
        city: user.city,
        state: user.state,
        country: user.country,
        company: user.company,
        last_name: user.last_name,
        first_name: user.first_name,
        postal_code: user.postal_code,
        address_line_one: user.address_line_one,
        address_line_two: user.address_line_two
      }
    }
  end

end
