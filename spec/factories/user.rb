# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sign_in_count { 3 }
    last_name { 'User' }
    first_name { 'Test' }
    password { 'Test@123' }
    email { Faker::Internet.email }
  end
end