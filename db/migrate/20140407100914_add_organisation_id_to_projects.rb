class AddOrganisationIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :organisation_id, :integer
  end
end
