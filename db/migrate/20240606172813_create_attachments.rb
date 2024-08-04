class CreateAttachments < ActiveRecord::Migration[7.2]
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true, null: false
      t.string :file

      t.timestamps
    end
  end
end
