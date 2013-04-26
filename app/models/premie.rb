class Premie < ActiveRecord::Base

	belongs_to :worker
	self.table_name = 'premie'
	
	validates_presence_of [:pe_tytul,:pe_data_od,:pe_data_do], :on => :create

	attr_accessible :id, 
					:pe_tytul,
					:pe_worker_id,
					:pe_data_od,
					:pe_data_do,
					:pe_wartosc,
					:pe_aud_us_id




end
