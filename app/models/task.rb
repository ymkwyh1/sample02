class Task < ApplicationRecord

    validates :name, presence: true
    validates :content, presence: true

    belongs_to :board
    belongs_to :user
    
end
