# frozen_string_literal: true

require 'memoist'

class County < ApplicationRecord
  extend Memxist

  # Associations
  belongs_to :state

  has_many :zipcodes, dependent: :destroy

  # Validations

  # rubocop: disable Rails/UniqueValidationWithoutIndex
  validates :name, uniqueness: { scope: :state_id, case_sensitive: false }, presence: true
  # rubocop: enable Rails/UniqueValidationWithoutIndex

  # Scopes
  scope :without_zipcodes, lambda {
    county = County.arel_table
    zipcodes = Zipcode.arel_table
    zip_join = county
               .join(zipcodes, Arel::Nodes::OuterJoin)
               .on(zipcodes[:county_id].eq(county[:id]))
    joins(zip_join.join_sources).where(zipcodes[:county_id].eq(nil))
  }
  scope :without_state, lambda {
    where(state_id: nil)
  }

  def cities
    zipcodes.map(&:city).sort.uniq
  end

  memoize :cities
end
