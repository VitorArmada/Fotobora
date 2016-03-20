class Entitytype < ActiveRecord::Base
  has_one :propertytype #propertytype for this entitytype that represents this entity the best 
  has_many :propertytypes
  belongs_to :entitytype #parent entitytype
  has_many :entitytypes #children entitytypes
  has_and_belongs_to_many :entities 

	def valid_propertytypes
		entitytype_list = []
		entitytype_current = self
		while not entitytype_current.nil? do 
			entitytype_list << entitytype_current.id
			entitytype_current = entitytype_current.entitytype
		end

		Propertytype.where(entitytype_id: entitytype_list).all
	end

end

