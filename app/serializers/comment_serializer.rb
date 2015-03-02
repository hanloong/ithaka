class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :anonymous, :idea_id
end
