# frozen_string_literal: true

FactoryBot.define do
  factory :response do
    question
    feedback

    trait :with_option do
      option
    end

    trait :with_body do
      body { Faker::Lorem.sentence }
    end
  end
end
