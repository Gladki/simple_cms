class AddTableForTabelaCzasowDostepnych < ActiveRecord::Migration
  def up
    create_table :tabela_czasow_dostepnych do |t|
	  t.integer :tcd_id_worker
	  t.integer :tcd_id_worker_merx

	  t.date :tcd_data
	  
	  t.decimal :tcd_sum_godz_przep, :precision => 10 , :scale => 2
	  t.decimal :tcd_sum_godz_chor, :precision => 10 , :scale => 2

	  t.string :tcd_import_file_info
	  t.string :tcd_aud_us_id
	  t.timestamps
	end
  end

  def down
  	drop_table :tabela_czasow_dostepnych
  end
end
