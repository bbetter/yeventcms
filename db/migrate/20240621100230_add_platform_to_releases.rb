class AddPlatformToReleases < ActiveRecord::Migration[7.2]
  def change
    add_column :releases, :platform, :integer
  end
end
