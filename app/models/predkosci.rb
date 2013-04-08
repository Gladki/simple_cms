class Predkosci < ActiveRecord::Base

	# belongs_to :worker
	self.table_name = 'predkosci'
	
	validates_presence_of [:pr_rodzaj_wozka], :on => :create
	attr_accessible :id, 
	             :pr_rodzaj_wozka, 
	             :pr_opis,
	             :pr_kod,
	             :pr_predkosc_km,
	             :pr_predkosc_metry,
	             :pr_tmu,
	             :pr_aud_us_id




end
