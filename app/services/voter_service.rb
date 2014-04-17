class VoterService
  attr_reader :vote

  def initialize(args)
    @vote = Vote.new(args)
  end

  def set_scope
    @vote.public = (@vote.idea.public && @vote.user.organisation != @vote.idea.organisation)
  end

  def place
    set_scope
    @vote.user && @vote.user.can_vote? && @vote.save
  end
end
