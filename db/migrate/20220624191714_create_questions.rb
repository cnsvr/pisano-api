class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.integer :type

      t.timestamps
    end
  end
end
