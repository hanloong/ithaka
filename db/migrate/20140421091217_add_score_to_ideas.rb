class AddScoreToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :influence, :float, default: 0
    add_column :ideas, :score, :float, default: 0
  end
end
