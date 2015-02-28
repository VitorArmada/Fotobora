class Entitystorycomment < ActiveRecord::Base
  belongs_to :entitystory
  belongs_to :user

  validates :text, presence: true

  def pretty_date
  	created_at.to_formatted_s(:short)
  end

end
