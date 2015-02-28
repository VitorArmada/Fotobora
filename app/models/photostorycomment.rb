class Photostorycomment < ActiveRecord::Base
  belongs_to :photostory
  belongs_to :user

  def pretty_date
  	created_at.to_formatted_s(:short)
  end

end
