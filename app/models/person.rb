class Person < ActiveRecord::Base
  belongs_to :father
  belongs_to :mother
  belongs_to :user
end
