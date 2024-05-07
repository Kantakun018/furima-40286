class CreateShiptoAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipto_addresses do |t|
      t.string      :postal_code,      null: false
      t.integer     :prefecture_id,    null: false
      t.string      :municipality,     null: false
      t.string      :street_number,    null: false
      t.string      :building_name
      t.string      :phone_number,     null: false
      t.references  :purchase_record,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
