class Votetype < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user
  belongs_to :entitytype
end
