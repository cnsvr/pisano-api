# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
