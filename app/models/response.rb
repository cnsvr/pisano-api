class Response < ApplicationRecord
     belongs_to :feedback
     belongs_to :question
     belongs_to :option, optional: true

     validates :option, presence: true, if: :question_type_is_choice?
     validates :body, presence: true, if: :question_type_is_text?
end
