class Effectivenes < ActiveRecord::Base

 belongs_to :worker
 attr_accessible :effectivity, :effectivity_max, :effectivity_min, :id, :worker_id
 
 def self.to_csv (options = {})
   CSV.generate(options) do |csv|
     csv << column_names
     all.each do |effectivity|
       csv << effectivity.attributes.values_at(*column_names)
     end
   end
  
 end

end
