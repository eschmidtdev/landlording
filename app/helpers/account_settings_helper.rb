# frozen_string_literal: true

module AccountSettingsHelper

  def card_number(user)
    if user.payment_detail.present?
      "************#{user.payment_detail&.card_number&.last(4)}"
    else
      '****************'
    end
  end

  def expiry_date(user)
    if user.payment_detail.present?
      "Expires #{user.payment_detail&.exp&.first(2)}/#{user.payment_detail&.exp&.last(2)}"
    else
      'Expires 00/00'
    end
  end

  def billing_address(user)
    if user.payment_detail.present? && (user.payment_detail&.address_line_one.present? && user.payment_detail&.address_line_two.present?)
      user.payment_detail&.address_line_one + ' ' + user.payment_detail&.address_line_two
    else
      '123 Apple Street, Unit 101, Austin, TX 78741'
    end
  end

  def card_brand(brand)
    image_tag "account_settings/#{brand}.png", class: ' pull-left mt-1', width: '30'
  end

end
