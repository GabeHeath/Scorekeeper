class CreateExpansions < ActiveRecord::Migration
  def change
    create_table :expansions do |t|
      t.string :name, :null => false
      t.integer :year
      t.integer :bgg_id

      t.timestamps null: false
    end
  end
end
