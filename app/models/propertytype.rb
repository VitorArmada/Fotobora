class Propertytype < ActiveRecord::Base
  belongs_to :entitytype
  has_many :properties
end
