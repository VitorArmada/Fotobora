class Entity < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  has_and_belongs_to_many :entitytypes
  has_many :properties
  has_many :entitystories
  

  accepts_nested_attributes_for :properties

	def summary_label
		if entitytypes.first.propertytype_id.nil? then 
			"" 
		else 
			property = properties.where(:propertytype_id => entitytypes.first.propertytype_id)
			.max { |a, b| (a.votes.count + a.certainty ) <=> (b.votes.count + b.certainty ) }
			property.nil? ? "" : property.value
		end
	end

	def full_label

		"(#{entitytypes.first.name}) #{summary_label}"
	end

	# criar lista vazia
	# pegar na entitytype da entidade e por na lista o id
	# pegar no pai de esse entitytype e por na lista o id dele
	# ate varrer a arvore toda para cima
	# depois tens uma lista de todos os entitytypes de quem esta entidade herda as propriedades
	# depois vais a tabela de propertytype e obtens todas as propriedades cujo o pai esteja incluido 
	# na lista de entitytypes 
	def valid_propertytypes
		entitytypes.map { |et| et.valid_propertytypes } .reduce(:concat).uniq{ |pt| pt.id }
		#entitytypes.valid_propertytypes
	end

	def has_property_values?(pt_id)
		not( properties.where(:propertytype_id => pt_id).empty? )
	end

	def get_property_values(pt_id)
		properties.where(:propertytype_id => pt_id)
		.sort { |b, a| (a.votes.count + a.certainty ) <=> (b.votes.count + b.certainty ) }
	end 

	def best_property_value(pt_id)
		values = properties.where(:propertytype_id => pt_id)
		if values.empty?
			"-"
		else
			values.max { |a, b| (a.votes.count + a.certainty ) <=> (b.votes.count + b.certainty ) }.value
		end
	end

	def pretty_date
		created_at.to_formatted_s(:short)
	end
end
