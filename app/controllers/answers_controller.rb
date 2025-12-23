class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]

  def create
  @answer = @question.answers.build(answer_params)
  @answer.user = current_user

  if @answer.save
    # ★ 回答が来たら「未解決」に戻す（任意だが実務的に◎）
    @question.update(resolved: false) if @question.resolved?

    redirect_to @question, notice: "回答を投稿しました"
  else
    redirect_to @question, alert: "回答の投稿に失敗しました"
  end
end


  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to @question, notice: "回答を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question, notice: "回答を削除しました"
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end
end
