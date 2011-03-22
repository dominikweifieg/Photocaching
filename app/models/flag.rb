class Flag < ActiveRecord::Base
  belongs_to :photo, :counter_cache => true
end
