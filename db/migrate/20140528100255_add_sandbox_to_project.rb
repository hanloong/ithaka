class AddSandboxToProject < ActiveRecord::Migration
  def change
    add_column :projects, :sandbox, :boolean, default: false
  end
end
