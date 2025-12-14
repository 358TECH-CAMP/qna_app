class SessionsController < ApplicationController
    def new
        # ログイン/新規登録フォームを表示
    end

    def create
        handle_name = params[:handle_name]
        role = params[:role]

        if handle_name.blank? || role.blank?
            # 入力がない場合はログイン画面に戻す
            redirect_to login_path, alert: "入力してください"
            return
        end

        # ハンドルネームで検索し、なければ新規作成
        user = User.find_or_initialize_by(handle_name: handle_name)
        user.role = role
        user.save!

        session[:user_id] = user.id

        # 役割によるリダイレクト制御
        if user.teacher?
            redirect_to questions_path # 講師は質問一覧へ
        else
            redirect_to new_question_path # 受講生は質問投稿へ
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end