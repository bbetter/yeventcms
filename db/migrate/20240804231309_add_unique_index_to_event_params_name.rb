class AddUniqueIndexToEventParamsName < ActiveRecord::Migration[7.0]
  def change
    duplicates = EventParam.select(:name)
      .group(:name)
      .having('COUNT(*) > 1')
      .pluck(:name)

    duplicates.each do |name|
      keep_id = EventParam.where(name: name).first.id
      EventParam.where(name: name).where.not(id: keep_id).delete_all
    end
    add_index :event_params, :name, unique: true
  end

  def down
    remove_index :event_params, :name
  end
end
