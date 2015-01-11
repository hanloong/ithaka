class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public, :idea_ids

  def idea_ids
    object.ideas.pluck(:id)
  end
end
