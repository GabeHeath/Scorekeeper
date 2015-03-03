class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :game_id, :null => false
      t.date :date, :null => false
      t.text :notes
      t.string :location
      t.datetime :created_at
      t.integer :created_by, :null => false

      t.timestamps null: false
    end
  end
end