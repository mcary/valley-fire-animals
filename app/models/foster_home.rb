class FosterHome < ActiveRecord::Base
  has_many :animals, through: :animal_foster_homes
  has_many :animal_foster_homes
end
