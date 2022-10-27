# frozen_string_literal: true

require 'memoist'

class State < ApplicationRecord
  extend Memoist

  # Associations
  has_many :zipcodes, dependent: :destroy
  has_many :counties, dependent: :destroy

  # Validations

  # rubocop: disable Rails/UniqueValidationWithoutIndex
  validates :abbr, uniqueness: { case_sensitive: false }, presence: true
  validates :name, uniqueness: { case_sensitive: false }, presence: true
  # rubocop: enable Rails/UniqueValidationWithoutIndex

  def cities
    zipcodes.map(&:city).sort.uniq
  end

  memoize :cities
end
