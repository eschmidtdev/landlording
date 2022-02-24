# frozen_string_literal: true

FactoryGirl.define do
  factory :card do
    card_holder_name 'MyString'
    card_number 'MyString'
    exp 'MyString'
    cvv 'MyString'
    user nil
  end
end
