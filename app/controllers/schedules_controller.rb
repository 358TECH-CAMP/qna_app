class SchedulesController < ApplicationController
  before_action :set_teacher, except: [:index_all]

  # 個別講師のスケジュール一覧（編集可能）
  def index
    @schedules = @teacher.schedules.order(:date, :time)
    @current_teacher = current_user&.teacher? && @teacher.id == current_user.teacher.id
  end

  # 全体スケジュール
  def index_all
    @schedules = Schedule.order(:date, :time)
  end

  # 新規スケジュール作成
  def new
    @schedule = @teacher.schedules.new
  end

  def create
    @schedule = @teacher.schedules.new(schedule_params)
    if @schedule.save
      redirect_to teacher_schedules_path(@teacher), notice: "スケジュールを保存しました"
    else
      render :new
    end
  end

  def destroy
    @schedule = @teacher.schedules.find(params[:id])
    @schedule.destroy
    redirect_to teacher_schedules_path(@teacher), notice: "スケジュールを削除しました"
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def schedule_params
    params.require(:schedule).permit(:date, :time)
  end
end
