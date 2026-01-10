class Teacher < ApplicationRecord
  has_many :schedules, dependent: :destroy
end
