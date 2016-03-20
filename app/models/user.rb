class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos
  has_many :photostories
  has_many :photostorycomments
  has_many :entities
  has_many :votes
  has_many :entitystories
  has_many :entitystorycomments
  
  has_many :people
  has_attached_file :gentree
  do_not_validate_attachment_file_type :gentree

  #has_attached_file :picture # use 32x32 thumb for photo pages
end
