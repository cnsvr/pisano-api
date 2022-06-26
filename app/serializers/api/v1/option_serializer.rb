# frozen_string_literal: true

module Api
  module V1
    class OptionSerializer < Api::V1::ApplicationSerializer
      attributes :id, :title
      belongs_to :question
    end
  end
end
