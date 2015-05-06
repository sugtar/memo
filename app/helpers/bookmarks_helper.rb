module BookmarksHelper
  def get_bookmark_data(id)
    bookmark = Hash.new
    bookmark_url_item = MemoItem.find(id)
    bookmark[:url] = bookmark_url_item
    bookmark_url_item.relationships.each do |relationship|
      if relationship.name.name == '#bookmark_title'
        bookmark[:title] = relationship.target_item
      elsif relationship.name.name == '#bookmark_comment'
        comment_item = relationship.target_item
        bookmark[:comment] = comment_item
        bookmark[:metadata] = Array.new
        comment_item.metadata.each do |metadatum|
          bookmark[:metadata] << metadatum
        end
      end
    end
    return bookmark
  end

  def create_metadata_str(metadata)
    metadata_str = ""
    metadata.each do |metadatum|
      metadata_str += (metadatum.name + ',')
    end
    if metadata_str.size > 1
      return metadata_str[0, (metadata_str.size - 1)]
    else
      return metadata_str
    end
  end
end
