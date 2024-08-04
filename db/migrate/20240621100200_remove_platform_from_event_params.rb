class RemovePlatformFromEventParams < ActiveRecord::Migration[7.2]
  def change
    remove_column :event_params, :platform, :integer
  end
end
