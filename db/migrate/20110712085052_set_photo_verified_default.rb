class SetPhotoVerifiedDefault < ActiveRecord::Migration
  def self.up
    change_column_default :photos, :verified, false
  end

  def self.down
    change_column_default :photos, :verified, true
  end
end