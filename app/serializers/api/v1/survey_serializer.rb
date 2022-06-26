class Api::V1::SurveySerializer < Api::V1::ApplicationSerializer
     attributes :id, :name
     has_many :questions
     has_many :feedbacks
end