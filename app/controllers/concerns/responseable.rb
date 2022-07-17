# frozen_string_literal: true

module Responseable
  extend ActiveSupport::Concern

  def render_response(success, message, method, url)
    render json: { success:, message:, method:, url: }
  end

end
