class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :project, index: true
      t.string :message
      t.references :user, index: true
      t.references :trackable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
