class Instructor < ApplicationRecord
    has_many :students, dependent: :destroy

    # Validations 
    validates :name, presence: true
end
