class CreateDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.string :name
      t.text :description
      t.integer :times_rated
      t.integer :rating
      t.integer :times_downloaded
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :designs
  end
end
