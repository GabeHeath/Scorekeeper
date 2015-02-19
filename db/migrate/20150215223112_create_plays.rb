class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :game_id, :null => false
      t.date :date, :null => false
      t.text :notes
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end