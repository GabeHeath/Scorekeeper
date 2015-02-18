class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      #t.references :games, :users
      t.integer :play_id, :null => false
      t.integer :game_id, :null => false#, :index => true
      t.integer :user_id, :null => false#, :index => true
      t.integer :score
      t.boolean :win, :default => 0
      t.date :date, :null => false
      t.text :notes
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end