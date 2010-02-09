class AddTagsToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :tags, :text
  end

  def self.down
    remove_column :designs, :tags
  end
end
