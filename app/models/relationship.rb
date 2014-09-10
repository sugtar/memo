class Relationship < ActiveRecord::Base
  belongs_to :name, class_name: "RelationshipName"
  belongs_to :source_item, class_name: "MemoItem", foreign_key: 'source_item_id'
  belongs_to :target_item, class_name: "MemoItem", foreign_key: 'target_item_id'
end
