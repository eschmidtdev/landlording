# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit destroy update]
  before_action :validate_property, only: %i[create update fetch_landlord]

  include Responseable

  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    resp = Properties::CreatePropertyService.call(merged_property_params, tenant_params)
    render_message(resp)
    return redirect_to(new_property_path) unless resp[:success]

    redirect_to(properties_url)
  end

  def edit; end

  def update
    resp = Properties::UpdatePropertyService.call(@property, property_params, tenant_params)
    render_message(resp)
    return redirect_to(properties_url) if resp[:success]

    redirect_to(edit_property_path(@property.id))
  end

  def destroy
    @property.destroy!
    flash[:notice] = 'Property has ben deleted successfully.'
    redirect_to(properties_url)
  end

  def fetch_landlord
    landlord_response = FetchLandlordService.call(current_user)
    render_response(landlord_response[:success], landlord_response[:message], landlord_response[:method], landlord_response[:url])
  end

  def fetch_zip_data
    response = ZipCodeService.call(params[:code])
    render_response(response[:success], response[:message], response[:method], response[:url])
  end

  private

  def set_property = @property = Property.find(params[:id])

  def property_params
    id = ['id']
    params.require(:property).permit(Property.column_names.reject { |k| id.include?(k) }.map(&:to_sym))
  end

  def tenant_params
    id = ['id']
    params.require(:tenant).permit(Tenant.column_names.reject { |k| id.include?(k) }.map(&:to_sym))
  end

  def merged_property_params = property_params.merge({ user_id: current_user.id })

  def validate_property
    response = Validators::PropertyValidatorService.call(params[:action], property_params.to_h, current_user)
    render_response(false, response[:message], response[:method], response[:url]) unless response.nil?
  end
end
