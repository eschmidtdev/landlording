# frozen_string_literal: true

class PropertyValidatorService < ApplicationService
  attr_reader :property_params

  def initialize(params_hash)
    @property_params = params_hash
  end

  def call
    params_missing?(property_params)
  end

  def params_missing?(property_params)
    if property_params.empty?
      return { method: 'params_missing?',
               message: 'Params are missing or values are empty' }
    end
  end

end
