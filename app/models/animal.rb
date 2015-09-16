class Animal < ActiveRecord::Base
  has_many :foster_homes, through: :animal_foster_homes
  has_many :animal_foster_homes
end
