class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.belongs_to :idea, index: true
      t.belongs_to :factor, index: true
      t.integer :score

      t.timestamps
    end
  end
end
