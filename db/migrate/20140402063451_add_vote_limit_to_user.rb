class AddVoteLimitToUser < ActiveRecord::Migration
  def change
    add_column :users, :vote_limit, :integer, default: 15
  end
end
