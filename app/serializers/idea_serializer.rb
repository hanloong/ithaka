class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :score, :anonymous, :favourites_count, :comments_count, :project_id

  def comments_count
    object.comments.count
  end
end
