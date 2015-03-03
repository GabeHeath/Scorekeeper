class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :play_id, :null => false
      t.integer :user_id
      t.integer :score
      t.boolean :win, :default => 0
      t.string :non_friend_name

      t.timestamps null: false
    end
  end
end
