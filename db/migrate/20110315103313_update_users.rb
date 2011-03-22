class UpdateUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :subscription_expires, :datetime
    add_column :users, :original_transaction_id, :string
    add_column :users, :original_purchase_date, :datetime
    add_column :users, :purchase_date, :datetime
    add_column :users, :subscription, :boolean
    add_column :users, :latest_receipt, :text
    add_column :users, :product_id, :string
  end

  def self.down
    remove_column :users, :product_id
    remove_column :users, :latest_receipt
    remove_column :users, :subscription
    remove_column :users, :purchase_date
    remove_column :users, :original_purchase_date
    remove_column :users, :original_transaction_id
    remove_column :users, :subscription_expires
  end
end