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

  def disabled?(property, value)
    !property.send("landlord_contact_#{value}").blank? && property.saved_landlord == true ? 'disabled' : ''
  end

  def bedrooms_a
    %w[Studio 1 2 3 4 5 6 7 8+]
  end

  def bedrooms_b
    %w[1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7+]
  end
end
