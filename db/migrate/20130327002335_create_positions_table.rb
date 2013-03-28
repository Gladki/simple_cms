class CreatePositionsTable < ActiveRecord::Migration
def change
    create_table :positions do |t|
	  t.integer :id
	  t.integer :worker_id		
	  t.string :name			
	  
	  t.timestamps
    end
  end
end