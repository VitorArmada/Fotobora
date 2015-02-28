class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :photostories
  has_many :entities

  has_attached_file :picture, :styles => {
    :normal => "800x600>",
  	:small => "300x200>",
  	:thumb => "100x100>"
  }

  do_not_validate_attachment_file_type :picture
  validates_attachment :picture, presence: true
  
  #validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png' ]

  def pretty_date_taken
    date.to_formatted_s(:short)
  end

  def pretty_date_uploaded
  	created_at.to_formatted_s(:short)
  end

end
