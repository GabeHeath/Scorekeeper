class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :play_id
      t.text :comment
      t.integer :reported, :limit => 1, :default => 0
      t.boolean :edited, :default => 0

      t.timestamps null: false
    end
  end
end
