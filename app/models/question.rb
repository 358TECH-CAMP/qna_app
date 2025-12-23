class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  # 公開質問のみ
  scope :public_only, -> { where(public: true) }
end
