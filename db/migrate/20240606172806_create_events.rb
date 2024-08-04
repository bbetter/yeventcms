class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :demoReleasedDate
      t.date :prodReleasedDate

      t.timestamps
    end

    create_join_table :events, :event_params do |t|
      t.index :event_id
      t.index :event_param_id
    end
  end
end
