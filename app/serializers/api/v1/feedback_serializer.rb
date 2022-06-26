class Api::V1::FeedbackSerializer < Api::V1::ApplicationSerializer
  attributes :id
  belongs_to :survey
end