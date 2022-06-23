# frozen_string_literal: true

class Property < ApplicationRecord

  # Associations
  belongs_to :user

  # Enums
  enum property_type: { 'Single-Family Home' => 0,
                        'Apartment/Condo' => 1
  }

  self.per_page = 5
end
