class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    
  end
  
  ##### new user #####
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save # if success, true
      log_in @user # logging in after sign up
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      
    else
      render 'new'
    end
    
  end
  
  
  ##### edit #####
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
    else
      render 'edit'
    end
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
