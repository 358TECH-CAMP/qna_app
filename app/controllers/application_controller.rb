class ApplicationController < ActionController::Base
  helper_method :current_user
   # ★ これを追加
  before_action :basic_auth, if: -> { Rails.env.production? }

  private

  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end
  
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
