# frozen_string_literal: true

module PropertiesHelper

  def property_index?(params)
    params[:controller] == 'properties' && params[:action] == 'index'
  end
end
