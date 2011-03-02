class UpdatePlaysTable < ActiveRecord::Migration
  def self.up
    add_column :plays, :thumb, :string
  end

  def self.down
    remove_column :plays, :thumb
  end
end