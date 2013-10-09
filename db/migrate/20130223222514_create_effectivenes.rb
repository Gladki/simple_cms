class CreateEffectivenes < ActiveRecord::Migration
  def change
    create_table :effectivenes do |t|
      t.integer :id
      t.integer :worker_id
      t.decimal :effectivity
      t.decimal :effectivity_min
      t.decimal :effectivity_max
      t.datetime :ef_data
      t.integer :ef_aud_us_id
      t.timestamps
    end
  end
end
