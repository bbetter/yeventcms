class AddPlatformToReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :releases, :platform, :integer
  end
end
