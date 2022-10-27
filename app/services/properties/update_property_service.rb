# frozen_string_literal: true

module Properties
  class UpdatePropertyService < ApplicationService
    attr_reader :property, :property_params, :tenant_params

    MESSAGES = {
      updated: I18n.t('Properties.Updated')
    }.freeze
    private_constant :MESSAGES

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
      tenant = property.tenant
      if property.update(property_params) && tenant.update(tenant_params)
        { success: true, message: MESSAGES[:updated] }
      else
        {
          success: false,
          message: property.errors.full_messages.present? ? property.errors.full_messages.join(', ') : tenant.errors.full_messages.join(', ')
        }
      end
    end
  end
end
