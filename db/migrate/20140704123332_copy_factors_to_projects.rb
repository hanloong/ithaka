class CopyFactorsToProjects < ActiveRecord::Migration
  def change
    Factor.all.each do |f|
      Project.where(" id != ?", f.project_id).each do |p|
        factor = Factor.create(name: f.name, is_negative: f.is_negative, project: p) unless Factor.where(name: f.name, project: p).any?
        Influence.joins(:idea).where('ideas.project_id = ? AND factor_id = ?', p.id, f.id).each do |inf|
          inf.update_attributes(factor: factor)
        end
      end
    end
  end
end
