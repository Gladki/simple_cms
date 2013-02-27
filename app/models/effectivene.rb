class Effectivene < ActiveRecord::Base

 belongs_to :worker
 attr_accessible :effectivity, :effectivity_max, :effectivity_min, :id, :worker_id
 

end
