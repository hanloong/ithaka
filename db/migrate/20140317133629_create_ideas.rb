class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.integer :status

      t.timestamps
    end
  end
end
