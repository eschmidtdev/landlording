# frozen_string_literal: true

module Properties
  class UpdatePropertyService < ApplicationService
    attr_reader :property, :property_params, :tenant_params

    def initialize(property, property_params, tenant_params)
      @property        = property
      @tenant_params   = tenant_params
      @property_params = property_params
    end

    def call
      update_property
    end

    private

    def update_property
      property.update(property_params)
    end

  end
end
