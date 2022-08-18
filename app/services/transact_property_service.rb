# frozen_string_literal: true

class TransactPropertyService < ApplicationService
  attr_reader :property_params, :tenant_params

  def initialize(property_params, tenant_params)
    @tenant_params   = tenant_params
    @property_params = property_params
  end

  def call
    ActiveRecord::Base.transaction do
      property = Property.new(property_params)
      property.save
      create_tenant(property) if tenant_params.present?
    end
  end

  private

  def merged_tenant_params(property_id) = tenant_params.merge({ property_id: })

  def create_tenant(property)
    tenant = Tenant.new(merged_tenant_params(property.id))
    tenant.save
  end
end
