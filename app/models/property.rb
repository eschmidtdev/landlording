# frozen_string_literal: true

class Property < ApplicationRecord
  # Associations
  belongs_to :user
  has_one :tenant, dependent: :destroy

  # Activerecord callbacks
  before_save :normalize_phone

  # Activerecord Validations
  validates :landlord_contact_phone, phone: true

  # Enums
  enum property_type: {
    'Single-Family Home' => 0,
    'Apartment/Condo' => 1
  }

  self.per_page = 6

  private

  def normalize_phone
    self.landlord_contact_phone = Phonelib.parse(landlord_contact_phone).full_e164
  end
end
