class Entitytype < ActiveRecord::Base
  has_one :propertytype
  has_many :propertytypes
end
