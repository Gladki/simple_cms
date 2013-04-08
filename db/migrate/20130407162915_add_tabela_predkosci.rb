class AddTabelaPredkosci < ActiveRecord::Migration
  def up
    create_table :predkosci do |t|
	  t.string :pr_rodzaj_wozka
	  t.string :pr_opis
	  t.string :pr_kod
	  
	  t.decimal :pr_predkosc_km, :precision => 10 , :scale => 2
	  t.decimal :pr_predkosc_metry, :precision => 10 , :scale => 2
	  t.decimal :pr_tmu, :precision => 10 , :scale => 2
	 
	  t.string :pr_aud_us_id
	  t.timestamps
	
	


  end


  end

  def down
  	drop_table :predkosci
  end
end
