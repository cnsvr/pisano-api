class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options, id: :uuid do |t|
      t.references :question, null: false, foreign_key: true, type: :uuid
      t.text :title

      t.timestamps
    end
  end
end
