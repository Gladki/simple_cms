class AddTabelaTransportowa < ActiveRecord::Migration
  def up
   create_table :tabela_transportowa do |t|
	  t.string :tt_nr_drogi
	  t.string :tt_nr_drogi_system
	  t.string :tt_przebieg_trasy
	  t.string :tt_opis_trasy
	  t.string :tt_typ_operacji
	  t.string :tt_obszar

	  t.string :tt_ruch_od
	  t.string :tt_ruch_do
	  t.string :tt_srodek_transportu

	  t.decimal :tt_dystans_od, :precision => 10 , :scale => 2
	  t.decimal :tt_dystans_do, :precision => 10 , :scale => 2

	  t.integer :tt_ilosc_zakretow
	  t.integer :tt_ilosc_start_stop

	  t.string :tt_rodzaj_pobrania

	  t.string :tt_komentarz

	  t.string :tt_predkosc_kod

	  t.string :tt_import_file_info
	  t.string :tt_aud_us_id

	  t.timestamps
	
  end


  end

  def down
  	drop_table :tabela_transportowa
  end
end
