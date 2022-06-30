# frozen_string_literal: true

class TransactPropertyService < ApplicationService
  attr_reader :property_params, :tenant_params

  def initialize(property_params, tenant_params)
    @tenant = tenant_params
    @property = property_params
  end

  def call
    ActiveRecord::Base.transaction do
      property = Property.new(@property)
      property.save
      tenant = Tenant.new(merged_tenant_params(property.id))
      tenant.save
    end
  end

  private

  def merged_tenant_params(property_id) = @tenant.merge({ property_id: })
end
