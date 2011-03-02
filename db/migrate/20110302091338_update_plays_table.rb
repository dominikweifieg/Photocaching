class UpdatePlaysTable < ActiveRecord::Migration
  def self.up
    add_column :plays, :url, :string
    add_column :plays, :thumb, :string
  end

  def self.down
    remove_column :plays, :thumb
    remove_column :plays, :url
  end
end