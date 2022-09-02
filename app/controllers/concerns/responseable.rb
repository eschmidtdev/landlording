# frozen_string_literal: true

module Responseable
  extend ActiveSupport::Concern

  def render_response(success, message, method, url)
    render json: { success:, message:, method:, url: }
  end

  def render_message(resp)
    case resp[:success]
    when true
      flash[:notice] = resp[:message]
    when false
      flash[:danger] = resp[:message]
    else
      flash[:error] = 'Something went wrong please try again.'
    end
  end

end
