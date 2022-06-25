# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.integer :type, default: 0, null: false

      t.timestamps
    end
  end
end
