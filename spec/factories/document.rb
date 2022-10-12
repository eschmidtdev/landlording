# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    interview_id  { SecureRandom.uuid }
    name          { Faker::Company.name }
  end
end
