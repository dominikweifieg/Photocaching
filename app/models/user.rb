class User < ActiveRecord::Base
  has_many :photos, :order => "created_at DESC", :limit => 12
  has_many :plays, :conditions => "end_time IS NOT NULL",:order => "created_at DESC", :limit => 12
  
  validates_uniqueness_of :identifier
  
  def to_param
	  "#{identifier}"
	end
end
