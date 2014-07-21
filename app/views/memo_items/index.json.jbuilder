json.array!(@memo_items) do |memo_item|
  json.extract! memo_item, :id, :body
  json.url memo_item_url(memo_item, format: :json)
end
