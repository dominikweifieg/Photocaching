class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :alias
      t.string :identifier
      t.string :device

      t.timestamps
    end
    
    add_index :users, :identifier
  end

  def self.down
    remove_index :users, :identifier
    drop_table :users
  end
end