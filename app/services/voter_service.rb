class VoterService
  attr_reader :vote

  def initialize(args)
    @vote = Vote.new(args)
  end

  def place
    @vote.user && @vote.user.can_vote? && @vote.save
  end
end
