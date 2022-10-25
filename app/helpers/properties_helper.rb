# frozen_string_literal: true

module PropertiesHelper
  def property_index?(params)
    params[:controller] == 'properties' && params[:action] == 'index'
  end

  def show_home_image(property_type)
    property_types = {
      'Single-Family Home' => image_tag('properties/my_properties_home_1.svg', width: '40'),
      'Apartment/Condo' => image_tag('properties/my_properties_home_2.svg', width: '40')
    }.freeze

    property_types[property_type]
  end

  def show_property_name(address_line_one, address_line_two)
    return complete_address(address_line_one, address_line_two) if address_line_one.present? && address_line_two.present?

    address_line_one
  end

  def complete_address(address_line_one, address_line_two) = "#{address_line_one}  #{address_line_two}"

  def show_tenant_name(property)
    return property.tenant.name if property.tenant.name.present?

    'None'
  end

  def disabled?(property, value)
    property.send("landlord_contact_#{value}").present? && property.saved_landlord == true ? 'disabled' : ''
  end

  def bedrooms_a
    %w[Studio 1 2 3 4 5 6 7 8+]
  end

  def map_bedrooms
    bedrooms_a.map { |room| [room] }
  end

  def bathrooms
    %w[1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7+]
  end

  def map_bathrooms
    bathrooms.map { |room| [room] }
  end
end
