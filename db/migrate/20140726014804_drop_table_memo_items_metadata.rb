class DropTableMemoItemsMetadata < ActiveRecord::Migration
  def change
    drop_table :memo_items_metadata
  end
end
