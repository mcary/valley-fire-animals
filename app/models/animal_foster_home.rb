class AnimalFosterHome < ActiveRecord::Base
  belongs_to :animal
  belongs_to :foster_home
end
