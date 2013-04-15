class Obszar < ActiveRecord::Base

	# belongs_to :worker
	self.table_name = 'obszary'
	
	 validates_presence_of [:ob_nazwa,:ob_opis], :on => :create
	attr_accessible :id, 
	             :ob_nazwa, 
	             :ob_magazyn,
	             :ob_opis,
	             :ob_kod,
	             :ob_wartosc,
	             :ob_aud_us_id




end
