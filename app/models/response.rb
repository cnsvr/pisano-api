# frozen_string_literal: true

# This is the model for the response API.
class Response < ApplicationRecord
  belongs_to :feedback
  belongs_to :question
  belongs_to :option, optional: true

  validates :option, presence: true, if: -> { question&.choice? }
  validates :body, presence: true, if: -> { question&.text? }

  before_validation :check_question_and_option_has_relationship

  private

  def check_question_and_option_has_relationship
    return if option.blank?
    return if question.options.include?(option)
    errors.add(:option, 'is not related to question')
  end
end
