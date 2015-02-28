# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' } { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(:email => 'sergio@fotobora.com', :password => 'asd', :password_confirmation => 'asd')
u.save!(:validate => false)

u2 = User.create(:email => 'vitor@fotobora.com', :password => 'asd', :password_confirmation => 'asd')
u2.save!(:validate => false)

p = Photo.create( { id: 1, address: 'One Street', date: Date.new(2014,2,1), user: u } )
p.picture = File.open('../1.jpg')
p.save!

Photostory.create( { photo_id: 1, id: 1, title: 'Piquenique na Avó Joana', user: u, text: 'Lembro-me desta tarde como se fosse ontem. Fizemos um piquenique para a quinta da avó, e depois fomos fazer uma caminhada. Perto do fim, chegamos à beira do tractor velho e dos cavalos, e decidimos tirar uma foto.' } )

Entitytype.create( { id: 1, name: 'Person', propertytype_id: 1 } )
Entitytype.create( { id: 2, name: 'Vehicle', propertytype_id: 3 } )
Entitytype.create( { id: 3, name: 'Place', propertytype_id: 6 } )
Entitytype.create( { id: 4, name: 'Pet', propertytype_id: 9 } )
Entitytype.create( { id: 5, name: 'Object', propertytype_id: 11 } )
Entitytype.create( { id: 6, name: 'Monument', propertytype_id: 12 } )

Propertytype.create( { entitytype_id: 1, id: 1, name: 'Name'  } )

Propertytype.create( { entitytype_id: 2, id: 2, name: 'Brand' } )
Propertytype.create( { entitytype_id: 2, id: 3, name: 'Model' } )
Propertytype.create( { entitytype_id: 2, id: 4, name: 'License Plate' } )
Propertytype.create( { entitytype_id: 2, id: 5, name: 'Owner' } )

Propertytype.create( { entitytype_id: 3, id: 6, name: 'Name' } )
Propertytype.create( { entitytype_id: 3, id: 7, name: 'Address' } )
Propertytype.create( { entitytype_id: 3, id: 8, name: 'Owner' } )

Propertytype.create( { entitytype_id: 4, id: 9, name: 'Name' } )
Propertytype.create( { entitytype_id: 4, id: 10, name: 'Owner' } )

Propertytype.create( { entitytype_id: 5, id: 11, name: 'Description' } )

Propertytype.create( { entitytype_id: 6, id: 12, name: 'Name' } )
Propertytype.create( { entitytype_id: 6, id: 13, name: 'Inauguration Date' } )

Entity.create( { photo_id: 1,
				 id: 1,
				 x1: 300, x2: 375, y1: 115, y2: 240,
				 user: u,
				 entitytype_id: 1
			   } )
Entity.create( { photo_id: 1,
				 id: 2,
				 x1: 400, x2: 460, y1: 230, y2: 360,
				 user: u,
				 entitytype_id: 1
			   } )
Entity.create( { photo_id: 1,
				 id: 3,
				 x1: 440, x2: 630, y1: 350, y2: 475,
				 user: u,
				 entitytype_id: 4
			   } )

Property.create( { entity_id: 1, propertytype_id: 1,
					id: 1, value: 'Joana Silva', certainty: 5  } )
Property.create( { entity_id: 2, propertytype_id: 1,
					id: 2, value: 'Ricardo Silva', certainty: 4  } )
Property.create( { entity_id: 3, propertytype_id: 9,
					id: 3, value: 'Bobi', certainty: 4  } )
Property.create( { entity_id: 3, propertytype_id: 9,
					id: 4, value: 'Tareco', certainty: 1  } )
Property.create( { entity_id: 3, propertytype_id: 10,
					id: 5, value: 'Ricardo Silva', certainty: 5  } )
