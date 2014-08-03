class MemoItem < ActiveRecord::Base
  has_and_belongs_to_many :metadata
end
