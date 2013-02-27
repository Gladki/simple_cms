class AddWorkers < ActiveRecord::Migration
   def change
    create_table :workers do |t|
      t.integer :id_worker
      t.integer :id_worker_merx
      t.string :last_name
	  t.string :first_name

      t.timestamps
    end
  end
end
