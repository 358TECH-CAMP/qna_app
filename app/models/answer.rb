class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :question
    
    validates :content, presence: true
end

### 3. コントローラ（機能連動と権限制御）