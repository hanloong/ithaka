class DropArea < ActiveRecord::Migration
  def change
    drop_table :areas
  end
end
