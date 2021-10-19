class Board < ApplicationRecord

    validates :name, presence: true
    validates :content, presence: true

    has_many :tasks, dependent: :destroy

end
