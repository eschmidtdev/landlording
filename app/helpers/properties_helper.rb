# frozen_string_literal: true

module PropertiesHelper

  def property_index?(params)
    params[:controller] == 'properties' && params[:action] == 'index'
  end

  def show_home_image(property_type)
    case property_type
    when 'Single-Family Home'
      image_tag 'properties/my_properties_home_1.svg', width: '40'
    when 'Apartment/Condo'
      image_tag 'properties/my_properties_home_2.svg', width: '40'
    else
      # type code here
    end
  end

  def show_property_name(address_line_one, address_line_two)
    address_line_one.present? ? address_line_one : '' + ' ' + address_line_two.present? ? address_line_two : ''
  end

  def show_tenant_name(property)
    if property&.tenants&.any? && property.tenants.last&.name.present?
      property.tenants.last&.name
    else
      'None'
    end
  end
end
