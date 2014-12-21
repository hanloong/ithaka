class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public

  has_many :ideas

  url :project
end
