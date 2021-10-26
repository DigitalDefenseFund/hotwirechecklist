class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :name
      t.references :checklist_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
