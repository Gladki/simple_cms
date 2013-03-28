class CreatePositionsWorkersTable < ActiveRecord::Migration
 def change
    create_table :positions_workers do |t|
	  t.integer :worker_id			
	  t.integer :position_id			
	
    end
  end
end
