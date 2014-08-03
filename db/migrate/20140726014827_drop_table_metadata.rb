class DropTableMetadata < ActiveRecord::Migration
  def change
    drop_table :metadata
  end
end
