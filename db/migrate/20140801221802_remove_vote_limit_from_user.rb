class RemoveVoteLimitFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :vote_limit
  end
end
