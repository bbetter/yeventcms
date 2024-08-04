class RemoveDemoAndProdReleaseDateFromEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :demo_release_date, :date
    remove_column :events, :prod_release_date, :date
  end
end
