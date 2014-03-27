class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :name
      t.belongs_to :area, index: true
      t.integer :weight
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
