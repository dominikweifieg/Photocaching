class Photo < ActiveRecord::Base
  acts_as_mappable :default_units => :kms, :default_formula => :flat
  belongs_to :user
  has_many :plays, :conditions => "end_time IS NOT NULL", :order => "end_time DESC"
  has_many :flags
end
