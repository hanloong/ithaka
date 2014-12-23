class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :created_at, :updated_at, :organisation_name, :avatar_url

  def organisation_name
    object.organisation.name
  end

  def profile_url
    if object.photo_url then object.photo_url
    elsif object.avatar_url.present? then object.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(object.email.downcase)
      "https://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=mm"
    end
  end
end
