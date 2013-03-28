class Position < ActiveRecord::Base

 has_and_belongs_to_many :workers
 attr_accessible :id, :name, :created_at , :updated_at
 
 


end
