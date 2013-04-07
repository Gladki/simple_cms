class AddTypyPracTable < ActiveRecord::Migration
  def up
   create_table :typy_czynnosci do |t|
   	t.string :tc_kod
   	t.string :tc_opis
   	t.string :tc_zrodlo_pochodzenia
    t.integer :tc_aud_us_id
   	
    t.timestamps
   end
  end

  def down
  	drop_table :typy_czynnosci 
  end
end
