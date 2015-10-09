class PostsController < ApplicationController
  def index
    @posts = Post.all 
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(params[:user_id])
    if @post.save
      @user.posts << @post
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    user_id = @post.user_id
    @user = User.find(user_id)
  end

  def edit
    @current_user = current_user
    if @current_user.id = params[:user_id]
      @post = Post.find(params[:id])
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to user_path
  end

  private
    def find_user
      @user = User.find(params[:user_id])
    end

    def find_post
      @post = Post.find(params[:id])
    end
    
    def post_params 
      params.require(:post).permit(:body)
    end
end
