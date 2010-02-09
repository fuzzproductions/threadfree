class AddIdsToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
    add_column :comments, :design_id, :integer
  end

  def self.down
    remove_column :comments, :design_id
    remove_column :comments, :user_id
  end
end
