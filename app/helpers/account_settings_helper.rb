# frozen_string_literal: true

module AccountSettingsHelper
  def user_name
    current_user.name.split(' ')
  end
end