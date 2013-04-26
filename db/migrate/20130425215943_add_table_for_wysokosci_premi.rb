class AddTableForWysokosciPremi < ActiveRecord::Migration
def up
    create_table :premie do |t|
	  t.string :pe_tytul
	  t.string :pe_worker_id
	  t.string :pe_data_od
	  t.string :pe_data_do

	  t.decimal :pe_wartosc, :precision => 10 , :scale => 2
	  t.string :pe_aud_us_id
	  t.timestamps


  end
end
  def down
  	drop_table :premie
  end
end
