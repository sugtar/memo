class CreateRelationshipNames < ActiveRecord::Migration
  def change
    create_table :relationship_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
