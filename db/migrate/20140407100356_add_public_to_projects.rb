class AddPublicToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :public, :boolean, defalut: false
  end
end
