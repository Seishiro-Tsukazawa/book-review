class Review < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2000}
  belongs_to :user
  belongs_to :book
  
  has_many :favorites, dependent: :destroy
  has_many :user_fav, through: :favarites, source: :user
  
  #def self.search_review(search)
    #if search
        #@book = Book.where("title Like? OR author Like?", "%#{search}%", "%#{search}%")
        #Review.where(book_id: @book.ids)
    #else
        #Review.all
    #end
  #end
  

end
