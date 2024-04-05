# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 | int    | null: false, unique: true |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_yomi     | string | null: false |
| first_name_yomi    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column                 | Type       | Options     |
| -----------------------| ---------- | ----------- |
| id                     | int        | null: false, unique: true |
| image                  | string     | null: false |
| name                   | string     | null: false |
| description            | text       | null: false |
| category               | string     | null: false |
| condition              | string     | null: false |
| shipping_fee           | string     | null: false |
| shipfrom_area          | string     | null: false |
| days_until_shipping    | string     | null: false |
| price                  | int        | null: false |
| purchase_status        | text       | 
| seller_id              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## shipto_address テーブル

| Column        | Type       | Options     |
| --------------| ---------- | ----------- |
| id            | int        | null: false, unique: true |
| postal_code   | string     | null: false |
| prefecture    | string     | null: false |
| municipality  | text       | null: false |
| street_number | text       | null: false |
| building_name | text       |
| phone_number  | int        | null: false |

### Association

- has_many :purchase_records

## purchase_records テーブル

| Column                 | Type    | Options                   |
| -----------------------| --------| ------------------------- |
| id                     | int     | null: false, unique: true |
| buyer_id               | int     | null: false, foreign_key: true |
| item_id                | int     | null: false, foreign_key: true |
| shipto_address_id      | int     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :shipto_address