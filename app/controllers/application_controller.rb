class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  # ログインしているユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしていなければログインページにリダイレクト
  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
