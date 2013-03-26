class AddGroup < ActiveRecord::Migration
 def change
    create_table :group do |t|
	  t.integer :id		
	  t.string :name			
	  
	  t.timestamps
    end
  end
end