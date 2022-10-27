# frozen_string_literal: true

class Subscription < ApplicationRecord
  # Associations
  belongs_to :user

  # Enums
  enum plan: {
    free: 0,
    premium_trail: 1,
    premium_monthly: 2,
    premium_annual: 3
  }
end
