class AnswersController < ApplicationController
    before_action :require_login
    before_action :set_question
    before_action :set_answer, only: [:edit, :update, :destroy]
    # 回答の編集・削除は本人だけ
    before_action :authorize_answer!, only: [:edit, :update, :destroy] 

    # 回答投稿 (回答権限制御)
    def create
        # 講師ではない（受講生）かつ非公開質問には回答させない
        if !current_user.teacher? && !@question.public
            redirect_to questions_path, alert: "非公開質問には回答できません"
            return
        end

        @answer = @question.answers.build(answer_params)
        @answer.user = current_user

        if @answer.save
            redirect_to questions_path, notice: "回答を投稿しました"
        else
            redirect_to questions_path, alert: "回答に失敗しました"
        end
    end

    def edit
        # authorize_answer! で権限チェック済み
    end

    def update
        if @answer.user == current_user && @answer.update(answer_params)
            redirect_to questions_path, notice: "回答を更新しました"
        else
            render :edit
        end
    end

    def destroy
        @answer.destroy if @answer.user == current_user
        redirect_to questions_path, notice: "回答を削除しました"
    end
    
    private

    def set_question
        @question = Question.find(params[:question_id])
    end

    def set_answer
        @answer = Answer.find(params[:id])
    end

    def answer_params
        params.require(:answer).permit(:content)
    end

    # 回答投稿者かどうかのチェック
    def authorize_answer!
        redirect_to questions_path, alert: "権限がありません" unless @answer.user == current_user
    end
end