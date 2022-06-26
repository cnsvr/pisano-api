class Api::V1::OptionSerializer < Api::V1::ApplicationSerializer
     attributes :id, :title
     belongs_to :question
   end