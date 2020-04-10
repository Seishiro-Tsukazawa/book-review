class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  def new
    @book = Book.find_by(isbn: params[:format])
    @review = current_user.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    
    if @review.save
      flash[:success] = "投稿しました"
      redirect_to root_url
    else
      flash[:danger] = "投稿できませんでした"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :book_id)
  end
end
