class AddNegativeToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :is_negative, :boolean, default: false
  end
end
