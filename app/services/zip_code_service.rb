# frozen_string_literal: true

class ZipCodeService < ApplicationService
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def call
    find_city_state_country
  end

  private

  def find_city_state_country
    return { success: false, message: 'Please enter postal code', method: nil, url: nil } if code.blank?

    zipcode = Zipcode.find_by(code:)
    if zipcode.nil?
      return { success: false, message: "[#{code}] is not a valid Zipcode.", method: nil, url: nil }
    end

    @counties = County.where('state_id = ?', zipcode.county.state_id)
    return_city_state zipcode
  end

  def return_city_state(zipcode)
    { success: true, message: { state: zipcode.state.name,
                                county: 'United States',
                                city: zipcode.city.titleize }, method: nil, url: nil }
  end

end
