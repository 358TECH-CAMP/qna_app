class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy, :resolve]

  def index
    @users = User.all

    # 🔑 表示権限ごとの質問取得
    @questions =
      if current_user.teacher?
        Question.all
      else
        Question.where("public = ? OR user_id = ?", true, current_user.id)
      end

    # ユーザー絞り込み
    if params[:user_id].present?
      @questions = @questions.where(user_id: params[:user_id])
    end

    # 未解決のみ
    if params[:unresolved_only] == "1"
      @questions = @questions.where(resolved: false)
    end

    # 未回答のみ
    if params[:unanswered_only] == "1"
      @questions = @questions.left_joins(:answers)
                             .group(:id)
                             .having("COUNT(answers.id) = 0")
    end

    # 並び順：未解決 → 解決済み、新しい順
    @questions = @questions.order(resolved: :asc, created_at: :desc)
  end

  def show
    # 🔒 非公開質問のアクセス制御
    if !@question.public && !current_user.teacher? && @question.user != current_user
      redirect_to questions_path, alert: "この質問は非公開です"
      return
    end

    @answers = @question.answers
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

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: "質問を更新しました"
    else
      render :edit
    end
  end

  # ★ 解決済み切り替え
  def resolve
    if current_user.teacher? || @question.user == current_user
      @question.update(resolved: params[:question][:resolved])
    end
    redirect_to @question
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
    params.require(:question).permit(:title, :content, :public)
  end
end
