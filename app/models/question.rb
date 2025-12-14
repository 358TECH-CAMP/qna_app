class Question < ApplicationRecord
    belongs_to :user
    has_many :answers, dependent: :destroy
    
    validates :title, :content, presence: true
    
    # 公開質問のみを取得するスコープ（受講生向け）
    scope :public_only, -> { where(public: true) }
end