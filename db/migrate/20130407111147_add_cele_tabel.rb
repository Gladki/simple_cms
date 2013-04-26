class AddCeleTabel < ActiveRecord::Migration
  def up
   create_table :cele do |t|
   	t.string :ce_minimum
   	t.string :ce_maximum
   	t.integer :ce_worker_id
    t.integer :ce_aud_us_id
   	t.data :ce_data
    t.timestamps
   end
  end

  def down
  	drop_table :cele 
  end
end