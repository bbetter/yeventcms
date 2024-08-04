class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.integer :environment
      t.date :released_at
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
