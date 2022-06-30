# frozen_string_literal: true

class PropertyValidatorService < ApplicationService
  attr_reader :property_params

  def initialize(property_params)
    @property_params = property_params
  end

  def call
    params_missing?(property_params)
  end

  def params_missing?(property_params)
    if property_params.empty?
      return { method: 'missing_property_params',
               message: 'Params are missing or values are empty' }
    end
  end

end
