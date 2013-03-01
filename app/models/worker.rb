class Worker < ActiveRecord::Base
 attr_accessible :id_worker, :id_worker_merx, :last_name, :first_name

  has_many :effectivenes, :class_name => "Effectivenes"

	def self.to_csv (options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |workers|
				csv << workers.attributes.values_at(*column_names)
			end
		end
	end


end
