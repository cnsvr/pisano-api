# frozen_string_literal: true

module Api
  module V1
    class ApplicationSerializer < ActiveModel::Serializer
      attribute :created_at, if: -> { object.respond_to?(:created_at) }
      attribute :updated_at, if: -> { object.respond_to?(:updated_at) }
    end
  end
end
