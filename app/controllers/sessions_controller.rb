class SessionsController < ApplicationController
  def new
  end
  
  def create
   user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user # defined in sessions_helper.rb
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination' # `now` is important
      render 'new'
    end
  end

  def destroy
  end
end
