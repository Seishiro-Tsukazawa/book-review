class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  
  def index
  end

  def show
    @user=User.find(params[:id])
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
    @user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_edit_params)
      flash[:success]="更新に成功しました"
      redirect_to @user
    else
      flash[:danger]="更新に失敗しました"
      render edit_user_url
    end
  end

  def destroy
  end
  
  def likes
    @user = User.find(params[:id])
    @liked_review = @user.fav_reviews
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_edit_params
    params.require(:user).permit(:name, :email, :self_introduction)
  end
end
