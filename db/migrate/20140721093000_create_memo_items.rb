class CreateMemoItems < ActiveRecord::Migration
  def change
    create_table :memo_items do |t|
      t.text :body

      t.timestamps
    end
  end
end
