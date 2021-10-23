class Task < ApplicationRecord

    has_one_attached :eyecatch

    validates :name, presence: true
    validates :content, presence: true

    has_many :comments, dependent: :destroy
    belongs_to :board
    belongs_to :user

    def author_name
        user.display_name
    end

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end
    
end
