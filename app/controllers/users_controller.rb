class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :likes]
  before_action :correct_user, only: [:edit, :update]
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
      redirect_to login_url
    else
      flash[:danger]="登録に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
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
  
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless @user == current_user
  end
end
