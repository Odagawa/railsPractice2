class UsersController < ApplicationController
  
  
  # these :logged_in_user etc are actions that occurs in a certain condition
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]


  def index
    @users = User.paginate(page: params[:page]) # not User.all
  end
  
  
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) # same as @user == current_user
      # both current_user are defined in sessions_helper.rb
    end

end
