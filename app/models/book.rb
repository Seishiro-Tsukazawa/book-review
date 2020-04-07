class Book < ApplicationRecord
  validates :title, :author, :publisher, :isbn, presence: true
  
end
