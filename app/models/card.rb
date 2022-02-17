# frozen_string_literal: true

class Card < ApplicationRecord
  # Association
  belongs_to :user
end
