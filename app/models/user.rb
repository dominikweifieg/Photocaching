class User < ActiveRecord::Base
  has_many :photos
  has_many :plays, :order => "created_at DESC"
  
  validates_uniqueness_of :identifier
end
