class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.integer :merchant_id, unique: true
      t.string :name
      t.string :email
      t.string :cif
      t.timestamps
    end

    add_index :merchants, :merchant_id
  end
end
