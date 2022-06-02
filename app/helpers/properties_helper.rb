# frozen_string_literal: true

module PropertiesHelper

  def property_index?(params)
    params[:controller] == 'properties' && params[:action] == 'index'
  end

  def show_home_image(index)
    if index.even? || index.zero?
      image_tag 'properties/my_properties_home_1.svg', width: '40'
    elsif index.odd?
      image_tag 'properties/my_properties_home_2.svg', width: '40'
    end
  end

  def show_property_name(index)
    if index.even? || index.zero?
      '123 Apple Street'
    elsif index.odd?
      '376 W Magnolia Ave 100'
    end
  end

  def show_tenant_name(index)
    if index.even? || index.zero?
      'Rashed Kabir'
    elsif index.odd?
      'Jon Cooper'
    end
  end
end
