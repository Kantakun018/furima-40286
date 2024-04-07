class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_yomi, presence: true
  validates :first_name_yomi, presence: true
  validates :birthday, presence: true

  # パスワードは、半角英数字混合での入力が必須であること
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  # お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  # お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。
  validates :last_name_yomi, format: { with: /\A[ァ-ヶー－]+\z/, message: "には全角カタカナを使用してください" }
  validates :first_name_yomi, format: { with: /\A[ァ-ヶー－]+\z/, message: "には全角カタカナを使用してください" }

end