class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :likes]
  
  def index
  end

  def show
    @user=User.find(params[:id])
    @reviews=@user.reviews.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]="登録に成功しました"
      redirect_to @user
    else
      flash[:danger]="登録に失敗しました"
      render :new
    end
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    @user.assign_attributes(introduction_params)
    if @user.save
      flash[:success]="自己紹介を更新しました"
      redirect_to @user
    else
      flash[:success]="更新に失敗しました"
      render :edit
    end
  end

  def destroy
  end
  
  def likes
    @user = User.find(params[:id])
    @liked_review = @user.fav_reviews.order(id: :desc).page(params[:page]).per(10)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def introduction_params
    params.require(:user).permit(:self_introduction)
  end
end
