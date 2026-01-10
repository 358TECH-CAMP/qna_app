class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :basic_auth, if: -> { Rails.env.production? }  # 本番環境のみ

  private

  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] &&
      password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # ログインしているユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしていなければログインページへ
  def authenticate_user!
    redirect_to login_path, alert: "ログインしてください" unless current_user
  end
end
