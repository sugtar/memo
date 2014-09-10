class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :source_item_id
      t.integer :target_item_id
      t.integer :name_id

      t.timestamps
    end
  end
end
