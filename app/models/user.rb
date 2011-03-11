class User < ActiveRecord::Base
  has_many :photos, :order => "created_at DESC", :limit => 10
  has_many :plays, :order => "created_at DESC"
  
  validates_uniqueness_of :identifier
  
  def to_param
	  "#{identifier}"
	end
end
