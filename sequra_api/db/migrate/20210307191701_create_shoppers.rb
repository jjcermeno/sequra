class CreateShoppers < ActiveRecord::Migration[6.0]
  def change
    create_table :shoppers do |t|
      t.integer :shopper_id, unique: true
      t.string :name
      t.string :email
      t.string :nif
      t.timestamps
    end

    add_index :shoppers, :shopper_id
  end
end
