# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    survey
    title { Faker::Lorem.sentence }
    type { 0 }
  end
end
