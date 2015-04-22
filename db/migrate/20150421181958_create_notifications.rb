class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notifier_id
      t.string :key
      t.integer :trackable_id
      t.boolean :read, :default => 0
      t.boolean :new, :default => 1

      t.timestamps null: false
    end
  end
end
