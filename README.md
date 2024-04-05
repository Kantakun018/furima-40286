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
| name                   | string     | null: false |
| description            | text       | null: false |
| category_id            | int        | null: false |
| condition_id           | int        | null: false |
| shipping_fee_id        | int        | null: false |
| prefecture_id          | int        | null: false |
| days_until_shipping_id | int        | null: false |
| price                  | int        | null: false |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## shipto_address テーブル

| Column        | Type       | Options     |
| --------------| ---------- | ----------- |
| id            | int        | null: false, unique: true |
| postal_code   | string     | null: false |
| prefecture_id | int        | null: false |
| municipality  | string     | null: false |
| street_number | string     | null: false |
| building_name | string     |
| phone_number  | int        | null: false |

### Association

- belongs_to :purchase_record

## purchase_records テーブル

| Column                 | Type    | Options                   |
| -----------------------| --------| ------------------------- |
| id                     | int     | null: false, unique: true |
| user                   | int     | null: false, foreign_key: true |
| item_id                | int     | null: false, foreign_key: true |
| purchase_record_id     | int     | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipto_address