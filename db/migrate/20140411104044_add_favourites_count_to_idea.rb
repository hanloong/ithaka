class AddFavouritesCountToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :favourites_count, :integer
  end
end
