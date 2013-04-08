class AddTableForTabelaNormatywow < ActiveRecord::Migration
  def up
    create_table :tabela_normatywow do |t|
	  t.string :tn_kod_czynnosci
	  t.string :tn_obszar
	  t.string :tn_opis_czynnosci
	  t.string :tn_opis_czynnosci_szczegolowy
	  t.string :tn_jednostka_odniesienia
	  t.decimal :tn_czas, :precision => 10 , :scale => 2
	  t.string :tn_komentarz
	  t.string :tn_import_file_info
	  t.string :tn_aud_us_id
	  t.timestamps
	
  end


  end

  def down
  	drop_table :tabela_normatywow
  end
end
