# frozen_string_literal: true

class PropertiesController < ApplicationController
  def index
    @properties = Property.paginate(page: params[:page]).order('id DESC')
  end

  def create; end

  def update; end

  def destroy; end
end
