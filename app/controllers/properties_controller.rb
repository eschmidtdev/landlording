# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[edit destroy]

  include Responseable

  MESSAGES = {
    created: I18n.t('Properties.Created'),
    deleted: I18n.t('Properties.deleted')
  }.freeze

  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create
    response = PropertyValidatorService.call(property_params.to_h, current_user)
    return render_response(false, response[:message], nil, nil) unless response.nil?

    TransactPropertyService.call(merged_property_params, tenant_params)
    flash[:notice] = 'New Rental Property was successfully added.'
    redirect_to properties_url
  end

  def edit; end

  def update; end

  def destroy
    @property.destroy
    flash[:notice] = MESSAGES[:deleted]
    redirect_to properties_url
  end

  def fetch_landlord
    response = PropertyValidatorService.call(property_params.to_h, current_user)
    return render_response(false, response[:message], nil, nil) unless response.nil?

    return_user current_user
  end

  def get_zip_data
    @zipcode = Zipcode.find_by(code: params[:code])
    if @zipcode
      @counties = County.where('state_id = ?', @zipcode.county.state_id)
      return_city_state @zipcode
    else
      if params[:code].blank?
        return true
      else
        if params[:code].is_zipcode?
          data = {
            'err' => "Could not find Zipcode [#{params[:code]}].  If this is a valid
                      zipcode please notify support, so we can update our database."
          }
        else
          data = {
            'err' => "[#{params[:code]}] is not a valid Zipcode."
          }
        end
        render text: data.to_json
      end
    end
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

  def return_user(user)
    render json: {
      success: true,
      user: {
        email: user.email,
        phone: user.phone_number,
        name: construct_user_name(user)
      }
    }
  end

  def return_city_state(zipcode)
    render json: {
      success: true,
      object: {
        state: zipcode.state.name,
        county: zipcode.county.name,
        city: zipcode.city.titleize
      }
    }

  end

  def construct_user_name(user)
    last_name = ''
    fist_name = ''
    last_name = user.last_name if user.last_name.present?
    fist_name = user.first_name if user.first_name.present?

    "#{fist_name} #{last_name}"
  end

end
