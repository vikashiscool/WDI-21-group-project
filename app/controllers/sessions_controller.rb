class SessionsController < ApplicationController
  def new
    redirect_to current_user if current_user
  end

  def create
    user = User.confirm(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
