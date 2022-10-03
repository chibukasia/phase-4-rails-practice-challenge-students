class Instructor < ApplicationRecord
    has_many :students

    # Validations 
    validates :name, presence: true
end
