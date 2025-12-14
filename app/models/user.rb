class User < ApplicationRecord
    has_many :questions
    has_many :answers

    # 必須チェックとユニークネスチェック
    validates :handle_name, presence: true, uniqueness: true
    # 役割は Student または Teacher のいずれかである必要がある
    validates :role, presence: true, inclusion: { in: %w[Student Teacher] }
    
    def teacher?
        role == "Teacher"
    end

    def student?
        role == "Student"
    end
end