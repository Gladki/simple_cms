class Worker < ActiveRecord::Base
 attr_accessible :id_worker, :id_worker_merx, :last_name, :first_name, :position_ids
 belongs_to :search
 has_many :effectivenes, :class_name => "Effectivenes"
 has_many :cele, :class_name => "Cele"


 has_and_belongs_to_many :positions

 validates_presence_of [:id_worker,:id_worker_merx,:last_name,:first_name], :on => :create
 validates_numericality_of [:id_worker,:id_worker_merx], :only_integer => true, :on => :create
	

	




	def self.to_csv (options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |workers|
				csv << workers.attributes.values_at(*column_names)
			end
		end
	end



	def self.search(search)
	  if search
	    find(:all, :conditions => ['id in (?)', search])
	  else
	    find(:all)
	  end
	end


end
