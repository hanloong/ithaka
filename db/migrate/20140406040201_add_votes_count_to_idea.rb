class AddVotesCountToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :votes_count, :integer
  end
end
