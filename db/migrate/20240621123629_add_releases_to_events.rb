class AddReleasesToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :ios_impl, :datetime
    add_column :events, :android_impl, :datetime
    add_column :events, :ios_release, :datetime
    add_column :events, :android_release, :datetime
  end
end
