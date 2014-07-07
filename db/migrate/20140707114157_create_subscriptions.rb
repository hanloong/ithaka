class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :transaction_id
      t.string :customer_id
      t.string :plan
      t.string :status
      t.boolean :active

      t.timestamps
    end
  end
end
