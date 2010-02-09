class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :page_text
      t.text :page_url

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
