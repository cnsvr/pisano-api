# frozen_string_literal: true

module Api
  module V1
    # This is a serializer for the questions API.
    class QuestionSerializer < Api::V1::ApplicationSerializer
      attributes :id, :title, :type

      belongs_to :survey
      has_many :options, if: -> { object.choice? }
      has_many :responses

      def type
        object.type.zero? ? 'text' : 'choice'
      end
    end
  end
end
