class CreateJoinTableMemoItemMetadatum < ActiveRecord::Migration
  def change
    create_join_table :memo_items, :memodata do |t|
      # t.index [:memo_item_id, :memodatum_id]
      # t.index [:memodatum_id, :memo_item_id]
    end
  end
end
