# frozen_string_literal: true

FactoryBot.define do
  factory :response do
    question
    feedback

    after(:build) do |response|
      if response.question.text?
        response.update(body: Faker::Lorem.sentence)
      elsif response.question.choice?
        response.update(option: response.question.options.first)
      end
    end
  end
end
