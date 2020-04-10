class Book < ApplicationRecord
  #validates :title, :author, :publisher, :isbn, presence: true
  has_many :reviews, dependent: :destroy
end
