class AddUnlockedToVote < ActiveRecord::Migration
  def change
    add_column :votes, :unlocked, :boolean, default: false
  end
end
