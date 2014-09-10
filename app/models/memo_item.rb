class MemoItem < ActiveRecord::Base
  # has many metadata
  has_and_belongs_to_many :metadata

  # has many source memo_items
  has_many :relationships, foreign_key: "source_item_id", dependent: :destroy
  has_many :source_items, through: :relationships, source: :source_item

  # has many target memo_items
  has_many :reverse_relationships, foreign_key: "target_item_id", class_name: "Relationship", dependent: :destroy
  has_many :target_items, through: :reverse_relationships, source: :target_item
end
