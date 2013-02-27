class CreateEffectivities < ActiveRecord::Migration
  def change
    create_table :effectivenes do |t|
      t.integer :id
      t.integer :id_worker
      t.decimal :effectivity
      t.decimal :effectivity_min
      t.decimal :effectivity_max

      t.timestamps
    end
  end
end
