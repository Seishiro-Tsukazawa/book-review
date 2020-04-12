class FavoritesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    current_user.like(review)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.unlike(review)
    redirect_back(fallback_location: root_path)
  end
end
