class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(handle_name: user_params[:handle_name])
    @user.role = user_params[:role]
    @user.save!

    session[:user_id] = @user.id

    if @user.teacher?
      redirect_to questions_path
    else
      redirect_to new_question_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle_name, :role)
  end
end
