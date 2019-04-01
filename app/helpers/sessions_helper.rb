module SessionsHelper
  # This helper is available in all controllers due to ApplicationController class.
  
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id # make temporary cookies encrypted
  end
  
  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id] # ログイン中かどうか
      @current_user ||= User.find_by(id: session[:user_id]) # nilなら代入
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
end
