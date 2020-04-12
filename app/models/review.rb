class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many :favorites
  has_many :user_fav, through: :favarites, source: :user
  

end
