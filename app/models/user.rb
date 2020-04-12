class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :self_introduction, length: { maximum: 500 }
  has_secure_password
  
  has_many :reviews
  
  has_many :favorites
  has_many :fav_reviews, through: :favorites, source: :review
  
  def like(review)
    self.favorites.find_or_create_by(review_id: review.id)
  end
  
  def unlike(review)
    like=self.favorites.find_by(review_id: review.id)
    like.destroy if like
  end
  
  def like?(review)
    self.fav_reviews.include?(review)
  end
  
end
