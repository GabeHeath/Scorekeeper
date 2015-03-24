class AddPlayerCountAndCommentCountToPlay < ActiveRecord::Migration
  def change
    add_column :plays, :players_count, :integer, :default => 0
    add_column :plays, :comments_count, :integer, :default => 0
  end
end
