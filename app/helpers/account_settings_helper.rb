# frozen_string_literal: true

module AccountSettingsHelper

  def card_number(payment_detail)
    return '****************' if payment_detail.card_number.nil?

    "************#{payment_detail.card_number.last(4)}"
  end

  def expiry_date(payment_detail)
    return 'Expires MM/YYYY' if payment_detail.exp.nil?

    "Expires #{payment_detail.exp.first(2)}/#{payment_detail.exp.last(2)}"
  end

  def billing_address(payment_detail)
    return 'Street, Suite, City, State Zip' if payment_detail.address_line_one.nil? && payment_detail.address_line_two.nil?

    payment_detail.address_line_one + ' ' + payment_detail.address_line_two
  end

  def card_brand(brand)
    image_tag "account_settings/#{set_brand(brand)}.png", class: ' pull-left mt-1', width: '30'
  end

  def set_brand(brand)
    return 'CardPlaceholder' if brand.nil?

    brand
  end

  def usage_date(payment_detail)
    return 'LAST USED MM/DD/YYYY' if payment_detail.last_used.nil?

    payment_detail.last_used.strftime('%m/%d/%Y')
  end

end
