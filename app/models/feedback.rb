# frozen_string_literal: true

# This is the model for the feedbacks API.
class Feedback < ApplicationRecord
  belongs_to :survey
  has_many :responses, dependent: :destroy
end
