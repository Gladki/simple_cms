class AddTableForObszar < ActiveRecord::Migration
def up
    create_table :obszary do |t|
	  t.string :ob_nazwa
	  t.string :ob_magazyn
	  t.string :ob_opis
	  t.string :ob_kod
	  t.decimal :ob_wartosc, :precision => 10 , :scale => 2
	  t.string :ob_aud_us_id
	  t.timestamps
	
  end


  end

  def down
  	drop_table :obszary
  end
end
