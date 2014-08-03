class CreatJoinTableMemoItemMetadatum < ActiveRecord::Migration
  def change
    create_join_table :memo_items, :metadata do |t|
      # t.index [:memo_item_id, :metadatum_id]
      # t.index [:metadatum_id, :memo_item_id]
    end
  end
end
