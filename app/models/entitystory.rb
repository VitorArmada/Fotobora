class Entitystory < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user
  has_many :entitystorycomments

  validates :title, :text, presence: true

  def summary_text
  	if text.length > 50
  		"#{text.slice(0,50)}..."
  	else
  		text
  	end
  end

  def pretty_date
    created_at.to_formatted_s(:short)
  end

end
