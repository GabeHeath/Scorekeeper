class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, :null => false
      t.integer :year
      t.integer :bgg_id
      t.string :game_type, :null => false

      t.timestamps null: false

      #t.references :plays, index: true
    end
  end
end
