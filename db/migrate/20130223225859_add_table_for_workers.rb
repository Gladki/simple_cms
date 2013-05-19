class AddTableForWorkers < ActiveRecord::Migration
  def up
    create_table :workers do |t|
      t.integer :id_worker
      t.integer :id_worker_hr
      t.integer :id_worker_merx
      t.string :jednostka_organizacyjna
      t.string :last_name
	  t.string :first_name
	  t.string :obszar
	  t.string :profil_merx
	  t.string :stanowisko
	  t.string :przelozony
	  t.string :przelozony_przelozonego
	  t.string :w_import_info

      t.timestamps
    end
  end

  def down
  	drop_table :workers
  end


end

  