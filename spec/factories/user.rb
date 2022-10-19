# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sign_in_count { 3 }
    phone_number  { '5551115555' }
    email         { Faker::Internet.email }
    last_name     { Faker::Name.last_name }
    first_name    { Faker::Name.first_name }
    password      { Faker::Internet.password(min_length: 8) }
  end
end
