class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :user_id
      t.string :url
      t.string :thumb
      t.float :lat
      t.float :lng
      t.string :license
      t.string :title
      t.string :description
      t.boolean :verified
      t.integer :inappropriate_count
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
