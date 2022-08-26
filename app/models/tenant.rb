# frozen_string_literal: true

class Tenant < ApplicationRecord

  # Associations
  belongs_to :property

  # Activerecord callbacks
  before_save :normalize_phone

  # Activerecord Validations
  validates :phone_number, phone: true, allow_blank: true
  validates :additional_tenant_phone, phone: true, allow_blank: true

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164
    self.additional_tenant_phone = Phonelib.parse(additional_tenant_phone).full_e164
  end

end
