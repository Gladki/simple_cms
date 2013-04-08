class Dodatki < ActiveRecord::Base

	# belongs_to :worker
	self.table_name = 'dodatki'
	
	 validates_presence_of [:do_rodzaj_wozka], :on => :create
	attr_accessible :id, 
	             :do_rodzaj_wozka, 
	             :do_opis,
	             :do_kod,
	             :do_czas_zakr,
	             :do_czas_start_stop,
	             :do_aud_us_id




end
