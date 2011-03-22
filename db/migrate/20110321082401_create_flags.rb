class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.column :reason, :integer
      t.column :photo_id, :integer
      
      t.timestamps
    end
    add_column :photos, :flags_count, :integer
  end

  def self.down
    remove_column :photos, :flags_count
    change_table :photo do |t|
    end
    drop_table :flags
  end
end