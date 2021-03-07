class CreateDisbursements < ActiveRecord::Migration[6.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant
      t.integer :week
      t.integer :year
      t.decimal :total_amount
      t.decimal :total_fee
      t.decimal :total_disbursement
      t.timestamps
    end
  end
end
