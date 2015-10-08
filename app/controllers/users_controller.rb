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
    if current_user.id == user_id.to_i
      @user = User.find(current_user.id)
      @posts = []
      @user.posts.each do |t|
        @posts.push(t)
      end
    else
      @user = User.find(user_id)
    end 
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
