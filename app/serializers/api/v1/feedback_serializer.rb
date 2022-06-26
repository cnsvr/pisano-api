# frozen_string_literal: true

module Api
  module V1
    class FeedbackSerializer < Api::V1::ApplicationSerializer
      attributes :id
      belongs_to :survey
    end
  end
end
