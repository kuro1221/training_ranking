class CreateTrainingRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :training_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :training_menu, null: false, foreign_key: true
      t.integer :count
      t.datetime :recorded_at, null: false

      t.timestamps
    end
  end
end
