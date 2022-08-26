# frozen_string_literal: true
module Properties
  class CreatePropertyService < ApplicationService
    attr_reader :property_params, :tenant_params

    MESSAGES = {
      created: I18n.t('Properties.Created'),
    }.freeze


    def initialize(property_params, tenant_params)
      @tenant_params = tenant_params
      @property_params = property_params
    end

    def call
      begin
        ActiveRecord::Base.transaction do
          property = Property.new(property_params)
          property.save!
          create_tenant(property) if tenant_params.present?
        end
        { success: true, message: MESSAGES[:created] }
      rescue => e
        { success: false, message: e.message }
      end
    end

    private

    def merged_tenant_params(property_id) = tenant_params.merge({ property_id: })

    def create_tenant(property)
      tenant = Tenant.new(merged_tenant_params(property.id))
      tenant.save
    end

  end
end
