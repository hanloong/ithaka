class AddAnonymousToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :anonymous, :boolean, default: false
  end
end
