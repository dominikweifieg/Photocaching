class Photo < ActiveRecord::Base
  acts_as_mappable :default_units => :kms, :default_formula => :flat
  belongs_to :user
  has_many :plays
  has_many :flags
end
