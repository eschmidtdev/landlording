# frozen_string_literal: true

class Property < ApplicationRecord

  # Associations
  belongs_to :user
  has_many :tenants, dependent: :destroy

  # Enums
  enum property_type: { 'Single-Family Home' => 0,
                        'Apartment/Condo' => 1 }

  self.per_page = 6
end
