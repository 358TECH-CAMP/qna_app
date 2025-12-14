class QuestionsController < ApplicationController
    before_action :require_login
    before_action :set_question, only: [:edit, :update, :destroy, :show]
    # 編集・削除は本人だけ
    before_action :authorize_user!, only: [:edit, :update, :destroy] 

    # 質問一覧 (公開/非公開制御)
    def index
        if current_user.teacher?
            @questions = Question.all.order(created_at: :desc) # 講師はすべて閲覧可能
        else
            @questions = Question.public_only.order(created_at: :desc) # 受講生は公開質問のみ閲覧可能
        end
    end

    def new
        @question = Question.new
    end

    def create
        @question = current_user.questions.build(question_params)
        if @question.save
            redirect_to questions_path, notice: "質問を投稿しました"
        else
            render :new
        end
    end

    def edit
        # authorize_user! で権限チェック済み
    end

    def update
        # 権限チェックは authorize_user! で行うため、ここでは update のみ
        if @question.user == current_user && @question.update(question_params)
            redirect_to questions_path, notice: "質問を更新しました"
        else
            render :edit
        end
    end

    def destroy
        @question.destroy if @question.user == current_user
        redirect_to questions_path, notice: "質問を削除しました"
    end
    
    private

    def set_question
        @question = Question.find(params[:id])
    end

    def question_params
        params.require(:question).permit(:title, :content, :public)
    end
    
    # 質問投稿者かどうかのチェック
    def authorize_user!
        redirect_to questions_path, alert: "権限がありません" unless @question.user == current_user
    end
end