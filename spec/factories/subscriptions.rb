# frozen_string_literal: true

FactoryGirl.define do
  factory :subscription do
    email 'MyString'
    first_name 'MyString'
    last_name 'MyString'
    company 'MyString'
    address_line_one 'MyString'
    address_line_two 'MyString'
    city 'MyString'
    zip_code 'MyString'
    country 'MyString'
    state 'MyString'
  end
end
