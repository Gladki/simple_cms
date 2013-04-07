class Cele < ActiveRecord::Base

	belongs_to :worker
	self.table_name = 'cele'
	
	validates_presence_of [:ce_minimum,:ce_maximum,:ce_worker_id], :on => :create
	validates_numericality_of [:ce_minimum,:ce_maximum], :only_integer => true, :on => :create
	attr_accessible :id, 
	             :ce_minimum, 
	             :ce_maximum,
	             :ce_worker_id,
	             :ce_aud_us_id	





end
