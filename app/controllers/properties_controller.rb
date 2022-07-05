# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit destroy]

  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    response = PropertyValidatorService.call(property_params.to_h)
    return render_response(response) unless response.nil?

    TransactPropertyService.call(merged_property_params, tenant_params)
    render json: { success: true,
                   message: 'Property has been created successfully.' }

  end

  def edit; end

  def update; end

  def destroy
    @property.destroy
    render json: { success: true,
                   message: 'Property has been deleted successfully.' }

  end

  def get_landlord
    return unless params[:property][:saved_landlord] == 'true'

    user = current_user
    render json: {
      user: { name: construct_user_name(user),
              phone: user.phone_number,
              email: user.email }
    }
  end

  private

  def set_property = @property = Property.find(params[:id])

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

  def construct_user_name(user)
    last_name = ''
    fist_name = ''
    last_name = user.last_name if user.last_name.present?
    fist_name = user.first_name if user.first_name.present?

    "#{fist_name} #{last_name}"
  end

end
