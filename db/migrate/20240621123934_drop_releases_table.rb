class DropReleasesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :releases do |t|
      t.integer :event_id
      t.datetime :environment
      t.datetime :released_at

      t.timestamps
    end
  end
end
