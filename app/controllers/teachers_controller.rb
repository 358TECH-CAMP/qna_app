class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to teacher_schedules_path(@teacher), notice: "講師を登録しました"
    else
      render :new
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers_path, notice: "講師を削除しました"
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :field, :bio)
  end
end
