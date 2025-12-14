class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    
    private
    
    def current_user
        # セッションに user_id があればユーザーを取得
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        current_user.present?
    end
    
    def require_login
        # ログイン必須チェック
        redirect_to login_path unless logged_in?
    end
end