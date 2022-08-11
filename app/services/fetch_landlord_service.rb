# frozen_string_literal: true

class FetchLandlordService < ApplicationService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    fetch_landlord
  end

  private

  def fetch_landlord
    { success: true, message: get_user_attributes(user), method: nil, url: nil }
  end

  def get_user_attributes(user)
    { email: user.email,
      phone: user.phone_number,
      name: construct_user_name(user)
    }
  end

  def construct_user_name(user)
    last_name = ''
    fist_name = ''
    last_name = user.last_name if user.last_name.present?
    fist_name = user.first_name if user.first_name.present?

    "#{fist_name} #{last_name}"
  end

end
