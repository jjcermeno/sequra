class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :disbursement
      t.references :merchant
      t.references :shopper
      t.integer :order_id, unique: true
      t.integer :ext_merchant_id
      t.integer :ext_shopper_id
      t.decimal :amount, default: 0.0
      t.decimal :fee, default: 0.0
      t.decimal :disbursement, default: 0.0
      t.datetime :completed_at
      t.boolean :completed, default: false
      t.integer :week
      t.integer :year
      t.timestamps
    end

    add_index :orders, :order_id
  end
end
