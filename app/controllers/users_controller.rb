class UsersController < ApplicationController
  def index
    @user = User.all
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user 
    else
      redirect_to  new_user_path
    end
  end

  def show
    user_id = params[:id]
    @posts = Post.where(user_id: user_id)
    @user = User.find(user_id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :languages)
  end

end
