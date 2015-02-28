# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' } { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(:email => 'sergio@fotobora.com', :password => 'asd', :password_confirmation => 'asd')
u.save!(:validate => false)

p = Photo.create( { id: 1, address: 'One Street', date: Date.new(2014,2,1), user: u } )
p.picture = File.open('../1.jpg')
p.save!

Entitytype.create( { id: 1, name: 'Vehicle', propertytype_id: 2 } )
Entitytype.create( { id: 2, name: 'Person', propertytype_id: 3 } )

Propertytype.create( { id: 1, name: 'Brand', entitytype_id: 1 } )
Propertytype.create( { id: 2, name: 'Model', entitytype_id: 1 } )
Propertytype.create( { id: 4, name: 'License Plate', entitytype_id: 1 } )
Propertytype.create( { id: 3, name: 'Name', entitytype_id: 2 } )

Entity.create( { id: 1, x1: 0, x2: 100, y1: 0, y2: 100,
				 user: u,
				 photo_id: 1,
				 entitytype_id: 1 } )

Property.create( { id: 1, value: 'Opel', certainty: 4, entity_id: 1, propertytype_id: 1 } )
Property.create( { id: 2, value: 'Renault', certainty: 5, entity_id: 1, propertytype_id: 1 } )
Property.create( { id: 3, value: 'Corsa', certainty: 4, entity_id: 1, propertytype_id: 2 } )
Property.create( { id: 4, value: 'Megane', certainty: 1, entity_id: 1, propertytype_id: 2 } )

Person.create( { id: 1, name: 'Avô 1', user: u } )
Person.create( { id: 2, name: 'Avó 1', user: u } )
Person.create( { id: 3, name: 'Avó 2', user: u } )
Person.create( { id: 4, name: 'Pai 1', user: u, father_id: 1, mother_id: 2 } )
Person.create( { id: 5, name: 'Mãe 1', user: u, mother_id: 3 } )
Person.create( { id: 6, name: 'Filho 1', user: u, father_id: 4, mother_id: 5 } )
Person.create( { id: 7, name: 'Filho 2', user: u, father_id: 4, mother_id: 5 } )


