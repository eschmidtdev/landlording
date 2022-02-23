# frozen_string_literal: true

class Subscription < ApplicationRecord
  # Associations
  belongs_to :user
end
