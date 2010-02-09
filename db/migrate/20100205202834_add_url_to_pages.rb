class AddUrlToPages < ActiveRecord::Migration
  def self.up
    remove_column :pages, :page_url
    add_column :pages, :page_url, :string
  end

  def self.down
    remove_column :pages, :page_url
    add_column :pages, :page_url, :text
  end
end
