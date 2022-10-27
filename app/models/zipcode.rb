# frozen_string_literal: true

class Zipcode < ApplicationRecord
  # Associations
  belongs_to :state
  belongs_to :county

  # Validations

  # rubocop: disable Rails/UniqueValidationWithoutIndex
  validates :code, uniqueness: true, presence: true
  # rubocop: enable Rails/UniqueValidationWithoutIndex

  validates :state_id, :county_id, :city, presence: true

  # Scopes
  scope :without_county, -> { where(county_id: nil) }
  scope :without_state, -> { where(state_id: nil) }
  scope :ungeocoded, -> { where('lat IS NULL OR lon IS NULL') }

  class << self
    def find_by_city_state(city, state)
      includes(county: :state)
        .where('city like ? AND states.abbr like ?', "#{city}%", "%#{state}%")
        .references(:state)
        .first
    end

    def find_all_by_city_state(city, state)
      includes(county: :state)
        .where('city like ? AND states.abbr like ?', "#{city}%", "%#{state}%")
        .references(:state)
    end
  end

  def latlon
    [lat, lon]
  end

  def geocoded?
    (!lat.nil? && !lon.nil?)
  end
end
