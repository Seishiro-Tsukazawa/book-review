class ToppagesController < ApplicationController
  def index
     reviews=Review.all
     @reviews=reviews.order(created_at: :desc)
     @review_rank=Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(3).pluck(:review_id))
  end
end
