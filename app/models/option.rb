# frozen_string_literal: true

# This is the model for the options API.
class Option < ApplicationRecord
  belongs_to :question

  validates :title, presence: true
end
