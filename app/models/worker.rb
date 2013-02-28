class Worker < ActiveRecord::Base
 attr_accessible :id_worker, :id_worker_merx, :last_name, :first_name

  has_many :effectivenes, :class_name => "Effectivenes"

	def self.search(search)
		if search
			find(:all, :conditions => ['workers.id LIKE (?)', "%#{search}%"])
		else
			find(:all, :conditions => ['effectivenes.created_at = ""'])
		end
	end


end
