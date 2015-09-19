class AnimalFosterHome < ActiveRecord::Base
  belongs_to :animal_type
  belongs_to :foster_home
end
