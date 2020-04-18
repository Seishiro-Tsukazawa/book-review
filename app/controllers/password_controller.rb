class PasswordController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    
  end
  
  def edit
    @user=current_user
  end
  
  def update
    @user=current_user
    current_password=params[:pass][:current_password]
    
    if current_password.present?
      if @user.authenticate(current_password)
        @user.assign_attributes(password_params)
        if @user.save
          flash[:success]="パスワードを変更しました"
          redirect_to @user
        else
          flash[:danger]="パスワードの更新に失敗しました"
          render :edit
        end
      else
        flash[:danger]="パスワードの更新に失敗しました"
        render :edit
      end
    else
      flash[:danger]="パスワードの更新に失敗しました"
      render :edit
    end
  end
  
  private
  
  def password_params
    params.require(:pass).permit(:current_password, :password, :password_confirmation)
  end
end
