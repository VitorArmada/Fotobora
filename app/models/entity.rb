class Entity < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  belongs_to :entitytype
  has_many :properties
  has_many :entitystories

  accepts_nested_attributes_for :properties

	def summary_label
		property = properties.where(:propertytype_id => entitytype.propertytype_id)
		.max { |a, b| (a.votes.count + a.certainty ) <=> (b.votes.count + b.certainty ) }
		property.nil? ? "" : property.value
	end

	def full_label
		"(#{entitytype.name}) #{summary_label}"
	end

	def valid_propertytypes
		Propertytype.all.where(:entitytype_id => entitytype.id)
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
