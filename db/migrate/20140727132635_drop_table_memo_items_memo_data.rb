class DropTableMemoItemsMemoData < ActiveRecord::Migration
  def change
    drop_table :memo_items_memodata
  end
end
