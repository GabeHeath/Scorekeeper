class CreatePlayExpansions < ActiveRecord::Migration
  def change
    create_table :play_expansions do |t|
      t.integer :play_id
      t.integer :expansion_id

      t.timestamps null: false
    end
  end
end
