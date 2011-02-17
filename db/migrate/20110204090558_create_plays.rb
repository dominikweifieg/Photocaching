class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.integer :user_id
      t.integer :photo_id
      t.integer :radius
      t.float :lat
      t.float :lng
      t.string :url
      t.datetime :end_time

      t.timestamps
    end
    add_index :plays, :user_id
    add_index :plays, :photo_id
  end

  def self.down
    remove_index :plays, :photo_id
    remove_index :plays, :user_id
    mind
    drop_table :plays
  end
end