class AddTableDodatki < ActiveRecord::Migration
 def up
    create_table :dodatki do |t|
	  t.string :do_rodzaj_wozka
	  t.string :do_opis
	  t.string :do_kod
	  
	  t.decimal :do_czas_zakr, :precision => 10 , :scale => 2
	  t.decimal :do_czas_start_stop, :precision => 10 , :scale => 2
	 
	 
	  t.string :do_aud_us_id
	  t.timestamps
	
  end


  end

  def down
  	drop_table :dodatki
  end
end
