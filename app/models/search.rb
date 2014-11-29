class Search
  def self.for(keyword)
    keyword_search = "%#{keyword.downcase}%"

    Project.where('lower(name) LIKE :keyword OR lower(description) LIKE :keyword ', keyword: keyword_search) +
      Idea.where('lower(name) LIKE :keyword OR lower(description) LIKE :keyword ', keyword: keyword_search) +
      Comment.where('lower(comment) LIKE ?', keyword_search)
  end
end
