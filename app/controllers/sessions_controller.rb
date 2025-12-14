class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(handle_name: params[:handle_name])
    if user
      session[:user_id] = user.id
      if user.teacher?
        redirect_to questions_path
      else
        redirect_to new_question_path
      end
    else
      redirect_to login_path, alert: "ユーザーが存在しません"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
