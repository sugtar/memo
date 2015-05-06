module MemoItemsHelper

  def create_relationship(source, target, name)
    relationship_name = RelationshipName.find_or_create_by(name: name)
    relationship = Relationship.new
    relationship.source_item = source
    relationship.target_item = target
    relationship.name = relationship_name
    relationship.save
  end
end
