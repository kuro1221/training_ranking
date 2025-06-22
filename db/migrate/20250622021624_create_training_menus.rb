class CreateTrainingMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :training_menus do |t|
      t.string :name
      t.text :rule

      t.timestamps
    end
  end
end
