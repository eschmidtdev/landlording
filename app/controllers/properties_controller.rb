# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit destroy update]
  before_action :validate_property, only: %i[create update]

  include Responseable

  MESSAGES = {
    updated: I18n.t('Properties.Updated'),
    created: I18n.t('Properties.Created'),
    deleted: I18n.t('Properties.deleted')
  }.freeze

  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    TransactPropertyService.call(merged_property_params, tenant_params)
    flash[:notice] = MESSAGES[:created]
    redirect_to properties_url
  end

  def edit; end

  def update
    Properties::UpdatePropertyService.call(@property, property_params, tenant_params)
    flash[:notice] = MESSAGES[:updated]
    redirect_to properties_url
  end

  def destroy
    @property.destroy
    flash[:notice] = MESSAGES[:deleted]
    redirect_to properties_url
  end

  def fetch_landlord
    response = PropertyValidatorService.call(property_params.to_h, current_user)
    return render_response(false, response[:message], response[:method], nil) unless response.nil?

    landlord_response = FetchLandlordService.call(current_user)
    render_response(landlord_response[:success], landlord_response[:message], landlord_response[:method], landlord_response[:url])
  end

  def get_zip_data
    response = ZipCodeService.call(params[:code])
    render_response(response[:success], response[:message], response[:method], response[:url])
  end

  private

  def set_property = @property = Property.find(params[:id])

  def property_params
    params.require(:property).permit(required_property_params)
  end

  def required_property_params
    Property.column_names.map(&:to_sym)
  end

  def tenant_params
    params.require(:tenant).permit(required_tenant_params)
  end

  def required_tenant_params
    Tenant.column_names.reject { |k| ['id'].include?(k) }.map(&:to_sym)
  end

  def merged_property_params = property_params.merge({ user_id: current_user.id })

  def validate_property
    response = PropertyValidatorService.call(property_params.to_h, current_user)
    unless response.nil?
      render_response(false, response[:message], response[:method], nil)
    end
  end

end
