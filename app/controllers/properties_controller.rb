# frozen_string_literal: true

class PropertiesController < ApplicationController
  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    binding.pry
    response = PropertyValidatorService.call(params_to_hash)

  end

  def update; end

  def destroy; end

  private

  def property_params
    params.require(:property).permit(required_property_params)
  end

  def tenant_params
    params.require(:tenant).permit(required_property_params)
  end

  def required_property_params
    Property.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def required_tenant_params
    Tenant.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def params_to_hash
    property_params.to_h
  end
end
