class CreateEventParams < ActiveRecord::Migration[7.0]
  def change
    create_table :event_params do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
