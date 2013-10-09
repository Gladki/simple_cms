class CreateJednostkaOrganizacyjna < ActiveRecord::Migration
def change
    create_table :jednostka_organizacyjna do |t|
	  t.integer :id
	  t.string :name			
	  t.string :w_import_info
	  t.timestamps
    end
  end
end