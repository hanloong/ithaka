class AddPublicToVote < ActiveRecord::Migration
  def change
    add_column :votes, :public, :boolean, default: false
  end
end
