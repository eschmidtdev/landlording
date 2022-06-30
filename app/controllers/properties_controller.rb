# frozen_string_literal: true

class PropertiesController < ApplicationController
  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    response = PropertyValidatorService.call(property_params.to_h)
    return render_response(response) unless response.nil?

    property = TransactPropertyService.call(merged_property_params, tenant_params)
    redirect_to properties_path
    # render json: { success: true,
    #                message: 'Property has been created successfully.' }

  end

  def update; end

  def destroy; end

  private

  def property_params
    params.require(:property).permit(required_property_params)
  end

  def tenant_params
    params.require(:tenant).permit(required_tenant_params)
  end

  def required_property_params
    Property.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def required_tenant_params
    Tenant.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def merged_property_params = property_params.merge({ user_id: current_user.id })

  def render_response(response)
    render json: { success: false,
                   message: response[:message] }
  end

end
