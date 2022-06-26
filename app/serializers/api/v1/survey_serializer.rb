# frozen_string_literal: true

module Api
  module V1
    class SurveySerializer < Api::V1::ApplicationSerializer
      attributes :id, :name
      has_many :questions
      has_many :feedbacks
    end
  end
end
