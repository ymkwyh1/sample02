class Task < ApplicationRecord

    validates :name, presence: true
    validates :content, presence: true

    has_many :comments, dependent: :destroy
    belongs_to :board
    belongs_to :user
    
end
