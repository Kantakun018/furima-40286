class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :municipality, :street_number, :building_name, :phone_number, :purchase_record,:user_id, :item_id

  with_options presence: true do
    validates :postal_code      , format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id    , numericality: { other_than: 1 , message: "can't be blank" }
    validates :municipality
    validates :street_number
    validates :phone_number     , numericality: { only_integer: true }, length: { in: 10..11 }
    validates :user_id
    validates :item_id
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)

    ShiptoAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      municipality: municipality,
      street_number: street_number,
      building_name: building_name,
      phone_number: phone_number,
      purchase_record_id: purchase_record.id
    )
  end
end