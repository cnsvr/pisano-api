class Api::V1::ApplicationSerializer < ActiveModel::Serializer
  attribute :created_at, if: -> { object.respond_to?(:created_at) }
  attribute :updated_at, if: -> { object.respond_to?(:updated_at) }
end