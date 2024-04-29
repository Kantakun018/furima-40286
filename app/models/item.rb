class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :purchase_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_until_shipping

  validates :image,                  presence: true
  validates :name,                   presence: true
  validates :description,            presence: true
  validates :category_id,            numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id,           numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_id,        numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id,          numericality: { other_than: 1 , message: "can't be blank"}
  validates :days_until_shipping_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price,                  presence: true
  validates :price,                  numericality: { only_integer: true }, numericality: { in: 300..9999999 }
end
