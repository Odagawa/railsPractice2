class SessionsController < ApplicationController
  def new
  end
  
  def create
   @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # ユーザーログイン後にリダイレクトする
      log_in @user # defined in sessions_helper.rb
      
      # if check box checked, remember me
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user # redirect_to @user if without memory
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination' # `now` is important
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
