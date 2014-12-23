class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :public
end
