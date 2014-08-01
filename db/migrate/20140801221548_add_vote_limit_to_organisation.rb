class AddVoteLimitToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :vote_limit, :integer, default: 15
  end
end
