class RemovePlatformFromEventParams < ActiveRecord::Migration[7.0]
  def change
    remove_column :event_params, :platform, :integer
  end
end
