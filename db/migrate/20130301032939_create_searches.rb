class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :keywords
      t.string :id_worker
      t.string :id_worker_merx
      t.integer :min_effectivity
      t.integer :max_effectivity
      t.string :stanowisko
      t.string :jedn_organizacyjna
      t.datetime :date_from
      t.datetime :date_to
      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
