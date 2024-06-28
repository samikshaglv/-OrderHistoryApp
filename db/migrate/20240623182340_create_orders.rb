class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :product_code
      t.date :date_of_purchase

      t.timestamps
    end
  end
end
