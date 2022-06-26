class Api::V1::QuestionSerializer < Api::V1::ApplicationSerializer
  attributes :id, :title, :type
  
  belongs_to :survey
  has_many :options, if: -> { object.choice? }
  has_many :responses
   
  def type
    object.type == 0 ? 'text' : 'choice'
  end
end