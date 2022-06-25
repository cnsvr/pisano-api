# frozen_string_literal: true

# This is the model for the questions API.
class Question < ApplicationRecord
  self.inheritance_column = nil # disable STI for type column
  QUESTION_TYPES = { 'text' => 0, 'choice' => 1 }.freeze

  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates :title, :type, presence: true
  validates :options, presence: true, if: :choice?
  validates_inclusion_of :type, in: QUESTION_TYPES.values, message: 'Type has to be 0 or 1'

  def text?
    type == QUESTION_TYPES['text']
  end

  def choice?
    type == QUESTION_TYPES['choice']
  end
end
