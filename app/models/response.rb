class Response < ApplicationRecord
     belongs_to :feedback
     belongs_to :question, optional: true
     belongs_to :option, optional: true
end
