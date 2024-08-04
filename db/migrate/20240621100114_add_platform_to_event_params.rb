class AddPlatformToEventParams < ActiveRecord::Migration[7.0]
  def change
    add_column :event_params, :platform, :integer
  end
end
