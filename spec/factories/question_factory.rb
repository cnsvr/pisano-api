# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    survey
    title { Faker::Lorem.sentence }
    type { 0 }

    trait :with_options do
      type { 1 }
      options { build_list(:option, 2) }
    end
  end
end
