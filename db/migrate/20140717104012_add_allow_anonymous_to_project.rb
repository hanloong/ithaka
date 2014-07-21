class AddAllowAnonymousToProject < ActiveRecord::Migration
  def change
    add_column :projects, :allow_anonymous, :boolean, default: false
  end
end
