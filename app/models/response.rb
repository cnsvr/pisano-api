# frozen_string_literal: true

# This is the model for the response API.
class Response < ApplicationRecord
  belongs_to :feedback
  belongs_to :question
  belongs_to :option, optional: true

  validates :option, presence: true, if: -> { question&.choice? }
  validates :body, presence: true, if: -> { question&.text? }
end
