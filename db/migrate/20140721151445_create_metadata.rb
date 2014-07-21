class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :body

      t.timestamps
    end
  end
end
