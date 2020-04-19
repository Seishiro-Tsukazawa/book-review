class ReviewsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :edit]
  def new
    @book = Book.find_by(isbn: params[:format])
    @review = current_user.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    
    if @review.save
      flash[:success] = "投稿しました"
      redirect_to @review
    else
      flash[:danger] = "投稿できませんでした"
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @reviews=@review.user.reviews.order(created_at: :desc)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(edit_review_params)
      flash[:success]="更新に成功しました"
      redirect_to @review
    else
      flash[:danger]="更新に失敗しました"
      render edit_review_url
    end
  end

  def destroy
    @review.destroy
    flash[:success]="削除しました"
    redirect_to user_path(current_user)
  end
  
  def search
    
    if params[:search].present?
      book = Book.where("title Like? OR author Like?", "%#{params[:search]}%", "%#{params[:search]}%")
      @reviews = Review.where(book_id: book.ids)
    else
      @reviews = Review.all
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content, :book_id)
  end
  
  def edit_review_params
    params.require(:review).permit(:content)
  end

  def correct_user
    @review=current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
  
end
