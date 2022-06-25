# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    title { Faker::Lorem.word }
    question
  end
end
