class Property < ActiveRecord::Base
  belongs_to :entity
  belongs_to :propertytype
  has_many :votes

  def user_has_voted_on_it?( user_id )
  	votes.any? { |v| v.user_id == user_id }
  end

  def total_votes_certainty 
  	total = 0
  	votes.each do |v| 
  		total += v.certainty
  	end
  	total
  end

end
