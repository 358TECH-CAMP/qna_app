class QuestionsController < ApplicationController
  before_action :authenticate_user!  # 追加
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: "質問を作成しました"
    else
      render :new
    end
  end

  def show
    @answers = @question.answers
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: "質問を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "質問を削除しました"
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
