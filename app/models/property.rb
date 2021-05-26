class Property < ApplicationRecord

  def self.find_prop( prop )
    self.where( "LOWER(:prop) = LOWER(code)", prop: prop )&.first.value
  end

  def self.locations
    JSON.parse( find_prop( :locations ) )
  end

end
