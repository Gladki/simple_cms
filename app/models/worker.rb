class Worker < ActiveRecord::Base
 attr_accessible :id_worker, :id_worker_merx, :last_name, :first_name

  has_many :effectivenes, :class_name => "Effectivenes"



end
