class Result < ApplicationRecord
    validates :key, presence: true
    validates :name, presence: true, length: { maximum: 15 }
    validates :category, presence: true, length: { maximum: 5 }
    validates :text, presence: true, length: { maximum: 500 }
    validates :minimum, presence: true
    validates :maximum, presence: true
    validates :average, presence: true
end