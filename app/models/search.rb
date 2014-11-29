class Search
  def self.for(current_user, keyword)
    keyword_search = "%#{keyword.downcase}%"

    Project.available(current_user.organisation).where('lower(name) LIKE :keyword OR lower(description) LIKE :keyword ', keyword: keyword_search) +
      Idea.where('lower(name) LIKE :keyword OR lower(description) LIKE :keyword ', keyword: keyword_search).select{|i| i.public || i.organisation == current_user.organisation} +
      Comment.where('lower(comment) LIKE ?', keyword_search).select{|c| c.public || c.organisation == current_user.organisation}
  end
end
