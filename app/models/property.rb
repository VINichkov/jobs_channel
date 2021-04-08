class Property < ApplicationRecord

  def self.find_prop(prop)
    self.where("LOWER(:prop) = LOWER(code)", prop: prop)&.first.value
  end
end
