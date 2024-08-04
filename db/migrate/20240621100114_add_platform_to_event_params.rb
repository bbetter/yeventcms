class AddPlatformToEventParams < ActiveRecord::Migration[7.2]
  def change
    add_column :event_params, :platform, :integer
  end
end
