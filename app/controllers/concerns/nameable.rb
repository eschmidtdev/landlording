# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern

  def construct_name(user, params)
    name = params[:first_name].split
    user.first_name = name.shift
    user.last_name = name.join(' ')
  end

end
