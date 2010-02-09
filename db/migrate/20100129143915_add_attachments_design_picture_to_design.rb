class AddAttachmentsDesignPictureToDesign < ActiveRecord::Migration
  def self.up
    add_column :designs, :design_picture_file_name, :string
    add_column :designs, :design_picture_content_type, :string
    add_column :designs, :design_picture_file_size, :integer
    add_column :designs, :design_picture_updated_at, :datetime
    
    add_column :designs, :approved, :boolean
  end

  def self.down
    remove_column :designs, :design_picture_file_name
    remove_column :designs, :design_picture_content_type
    remove_column :designs, :design_picture_file_size
    remove_column :designs, :design_picture_updated_at
    
    remove_column :designs, :approved
  end
end
