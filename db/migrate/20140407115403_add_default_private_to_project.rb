class AddDefaultPrivateToProject < ActiveRecord::Migration
  def change
    change_column :projects, :public, :boolean, default: false
  end
end
