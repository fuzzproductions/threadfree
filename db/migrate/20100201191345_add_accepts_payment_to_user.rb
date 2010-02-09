class AddAcceptsPaymentToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :accepts_payment, :boolean, :default => false
  end

  def self.down
    remove_column :users, :accepts_payment
  end
end
