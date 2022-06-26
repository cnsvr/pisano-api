# frozen_string_literal: true

module Api
  module V1
    class ResponseSerializer < Api::V1::ApplicationSerializer
      attribute :id
      attribute :body, if: -> { object.question.text? }

      belongs_to :question
      belongs_to :feedback
      belongs_to :option, if: -> { object.question.choice? }
    end
  end
end
