class Api::V1::ResponseSerializer < Api::V1::ApplicationSerializer
     attribute :id
     attribute :body, if: -> { object.question.text? }
     
     belongs_to :question
     belongs_to :feedback
     belongs_to :option, if: -> { object.question.choice? }
end