class Effectivenes < ActiveRecord::Base

 attr_accessible :effectivity, :effectivity_max, :effectivity_min, :id, :worker_id
 belongs_to :worker

end
