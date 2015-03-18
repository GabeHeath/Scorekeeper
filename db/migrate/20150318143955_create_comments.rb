class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :play_id
      t.text :comment
      t.integer :score, :limit => 1

      t.timestamps null: false
    end
  end
end
