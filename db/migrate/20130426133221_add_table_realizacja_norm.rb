class AddTableRealizacjaNorm < ActiveRecord::Migration
  def up
    create_table :realizacja_norm do |t|
	  t.integer :rn_id_worker
	  t.integer :rn_id_worker_merx

	  t.date :rn_data
	  
	  t.string :rn_obszar
	  t.string :rn_magazyn
	  t.string :rn_typ_operacji
	  t.string :rn_komentarz
	  

	  t.decimal :rn_normatywy_czas_suma_tg, :precision => 10 , :scale => 2
	  t.decimal :rn_normatywy_czas_suma_tj, :precision => 10 , :scale => 2
	  t.decimal :rn_tabela_transportowa_suma_tg, :precision => 10 , :scale => 2
	  t.decimal :rn_tabela_transportowa_suma_tj, :precision => 10 , :scale => 2
	  t.decimal :rn_suma_tj, :precision => 10 , :scale => 2

	  t.string :rn_import_file_info
	  t.string :rn_aud_us_id
	  t.timestamps
	end
  end

  def down
  	drop_table :realizacja_norm
  end
end
