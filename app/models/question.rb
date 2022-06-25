class Question < ApplicationRecord
     self.inheritance_column = nil # disable STI for type column
     QUESTION_TYPES = { 'text' => 0, 'choice' => 1 }
    
     belongs_to :survey
     has_many :options, dependent: :destroy

     validates :title, presence: true
     validates :type, presence: true, inclusion: { in: QUESTION_TYPES.values, message: "%{value} is not a valid question type. It has to be 0 or 1" }
     validates :options, presence: true, if: :is_choice?

     def is_text?
          type == QUESTION_TYPES['text']
     end

     def is_choice?
          type == QUESTION_TYPES['choice']
     end
end
